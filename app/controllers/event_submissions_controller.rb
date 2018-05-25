class EventSubmissionsController < AuthenticatedController
  before_action :find_unit
  before_action :find_event
  before_action :find_submission, except: [:new, :create, :index]

  def index
    @submissions = @event.event_submissions

    # apply filtering
    event_registration_id = params[:registration]
    event_requirement_id  = params[:requirement]
    @submissions = @submissions.select { |sub| sub.event_registration_id == event_registration_id.to_i } if event_registration_id.present?
    @submissions = @submissions.select { |sub| sub.event_requirement_id  == event_requirement_id.to_i } if event_requirement_id.present?

    respond_to do |format|
      format.json { render json: @submissions }
    end
  end

  def show
    # TODO: pundit this
  end

  def new
    @submission = EventSubmission.new
  end

  def create
    @submission = EventSubmission.new(submission_params)

    # destroy any 
    EventSubmission.where(
      event_requirement_id: @submission.event_requirement_id,
      event_registration_id: @submission.event_registration_id
    ).destroy_all

    if @submission.save
      redirect_to unit_event_event_registrations(@unit, @event, @submission.event_registration)
    end
  end

  private

  def find_unit
    @unit = @current_user.units.find(params[:unit_id])
  end

  def find_event
    @event = @unit.events.find(params[:event_id])
  end

  def find_submission
    @submission = EventSubmission.find(params[:id])
  end

  def submission_params
    params
      .require(:event_submission)
      .permit(:event_requirement_id, :event_registration_id, :attachment)
      .merge({ submitter: @current_user })
  end
end
