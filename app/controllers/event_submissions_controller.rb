# require 'combine_pdf'

class EventSubmissionsController < EventContextController
  before_action :find_submission, except: [:new, :create, :index]

  def index
    @submissions = @event.event_submissions

    # apply filtering
    event_registration_id = params[:registration]
    event_requirement_id  = params[:event_requirement_id]
    @submissions = @submissions.select { |sub| sub.event_registration_id == event_registration_id.to_i } if event_registration_id.present?
    @submissions = @submissions.select { |sub| sub.event_requirement_id  == event_requirement_id.to_i } if event_requirement_id.present?

    event_requirement = @event.event_requirements.find(event_requirement_id) if event_requirement_id.present?

    puts event_requirement_id

    respond_to do |format|
      format.json { render json: @submissions }
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
    end
  end

  def show
    # TODO: pundit this
  end

  def new
    @submission = EventSubmission.new
    @submission.event_requirement_id  = params[:requirement]
    @submission.event_registration_id = params[:registration]

    # iterate through all event registrations and determine whether current user is allowed to
    # submit on behalf of that user. Admins can submit on behalf of anyone. Users can always submit
    # on their own behalf. Guardian can submit on behalf of their guardees. All others are prohibited.
    # TODO: extract this
    @visible_event_registrations = []
    @event.event_registrations.each do |registration|
      if @current_user_is_admin
        @visible_event_registrations << registration
      elsif registration.user == @current_user
        @visible_event_registrations << registration
      elsif @current_user.guardees.include? registration.user
        @visible_event_registrations << registration
      else
        # nope
      end
    end
  end

  def create
    @submission = EventSubmission.new(submission_params)

    # destroy any
    EventSubmission.where(
      event_requirement_id: @submission.event_requirement_id,
      event_registration_id: @submission.event_registration_id
    ).destroy_all

    if @submission.save
      redirect_to unit_event_event_registration_path(@unit, @event, @submission.event_registration)
    end
  end

  private

  def find_submission
    @submission = EventSubmission.find(params[:id])
  end

  def submission_params
    params
      .require(:event_submission)
      .permit(:event_requirement_id, :event_registration_id, :attachment, :audience)
      .merge({ submitter: @current_user })
  end
end
