# this is the controller used when submitting at the Event level
# (where the requirement being fulfilled isn't yet known)

class EventSubmissionsController < AuthenticatedController
  before_action :find_submission, except: [:new, :create, :index]

  def index
    @submissions = @event.event_submissions

    # apply filtering
    event_registration_id = params[:registration]
    event_requirement_id  = params[:event_requirement_id]
    @submissions = @submissions.select { |sub| sub.event_registration_id == event_registration_id.to_i } if event_registration_id.present?
    @submissions = @submissions.select { |sub| sub.event_requirement_id  == event_requirement_id.to_i } if event_requirement_id.present?

    event_requirement = @event.event_requirements.find(event_requirement_id) if event_requirement_id.present?

    respond_to do |format|
      format.json { render json: @submissions || [] }

      # make a PDF
      format.pdf do
        pdf_combiner = CombinePDF.new
        @submissions.each do |submission|
          if submission.attachment.attached?
            pdf_combiner << CombinePDF.parse(submission.attachment.download)
          end
        end

        combined_filename = [
          UnitPresenter.unit_display_name(@unit),
          @unit.city,
          "#{event_requirement.description.pluralize}.pdf"
        ].join(' ')

        send_data pdf_combiner.to_pdf, filename: combined_filename, type: "application/pdf"
      end

      # make a zip file
      format.zip do
        combined_filename = [
          UnitPresenter.unit_display_name(@unit),
          @unit.city,
          "#{event_requirement.description.pluralize}.zip"
        ].join(' ')

        temp = Tempfile.new("scoutaround-event-#{@event.id}.zip")

        Zip::OutputStream.open(temp.path) do |zip|
          @submissions.each do |submission|
            # puts "Checking #{ submission.event_requirement.description }"
            if submission.attachment.attached?
              # puts "Adding #{ submission.event_requirement.description }"
              # puts submission.attachment.path
              # zip.add("#{ submission.event_registration.user.full_name }.pdf", submission.attachment.download)
              zip.put_next_entry("#{ submission.event_registration.user.full_name }.pdf")
              # zip.write submission.attachment.download

              binary = submission.attachment.download.delete("\u0000")

              zip.print binary

            end # if
          end # each submission
        end # zip output stream

        send_file temp.path, type:        'application/zip',
                             disposition: 'inline',
                             filename:    combined_filename

        # temp.close
        # temp.unlink
      end # format.zip
    end # respond_to
  end # index

  def show
    # TODO: pundit this
  end

  def create
    @submission = EventSubmission.new(submission_params)


    # resolve the EventRequirement
    @event_requirement = EventRequirement.find(params[:event_requirement_id]) if params[:event_requirement_id].present?
    @event_requirement ||= EventRequirement.find(@submission.event_requirement_id)
    @event = @event_requirement.event
    @submission.event_requirement = @event_requirement

    # destroy any previous submissions for this requirement, for this registration
    EventSubmission.where(
      event_requirement_id:  @event_requirement.id,
      event_registration_id: @submission.event_registration.id
    ).destroy_all

    case @event_requirement.type
    when 'FeeEventRequirement'

      # TODO: extract this into a standalone module

      total = 0
      @current_user.family.each do |user|
        if user.is_member_of?(unit: @unit)
          registration = @event.event_registrations.find_by(user: user)
          if registration.present?
            user_fee = user.type == 'Youth' ? @event_requirement.amount_youth : @event_requirement.amount_adult
            total += user_fee
          end
        end
      end

      processing_fee = total * 0.029 + 30
      total += processing_fee

      expiration        = params[:expiration]
      expiration_parts  = expiration.split('/')
      exp_month         = expiration_parts[0]
      exp_year          = expiration_parts[1]
      card_number       = params[:card_number]
      cvc               = params[:cvc]

      description = "#{ UnitPresenter.unit_display_name(@event.unit )} #{ @event.name } #{ @submission.event_registration.user.full_name }"

      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      charge = Stripe::Charge.create(
        amount:      total.to_i,
        currency:    'usd',
        description: description,
        source: {
          exp_month: exp_month,
          exp_year:  exp_year,
          number:    card_number,
          cvc:       cvc,
          object:    'card',
        }
      )

      # TODO: handle failed charges

      @submission.stripe_charge_id = charge.id

      # TODO: save card source data if user wants us to keep it on file

      if @submission.save!
        # because payment is for the entire family, let's create
        # payment submissions for them, too
        @current_user.guardees.each do |user|
          ap user.first_name
          registration = @event.event_registrations.find_by(user: user)
          ap registration
          if registration.present?
            submission = @event_requirement.event_submissions.new(
              event_registration: registration,
              submitter: @current_user
            )
            submission.save!
            ap submission
          end
        end

        # send email, set flash, redirect
        flash[:notice] = 'You\'ve paid!'
        EventSubmissionNotifier.send_payment_receipt_notification(@submission)
        redirect_to event_path(@event)
      end
    when 'DocumentEventRequirement'
      if @submission.save
        EventSubmissionNotifier.send_document_receipt_notifications(@submission)
        flash[:notice] = I18n.t(
          'submissions.confirmation.document_received',
          person: @submission.event_registration.user.full_name,
          document_name: @submission.event_requirement.description
        )
        redirect_to event_event_registrations_path(@event)
      end
    end
  end

  private

  def find_submission
    @submission = EventSubmission.find(params[:id])
    @unit = @submission.event_requirement.event.unit
  end

  def submission_params
    params
      .require(:event_submission)
      .permit(:event_registration_id, :event_requirement_id, :attachment)
      .merge({ submitter: @current_user })
  end
end
