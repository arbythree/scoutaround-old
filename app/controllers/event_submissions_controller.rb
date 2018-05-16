class EventSubmissionsController < AuthenticatedController
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
    @event = Event.find(params[:event_id])
    @submission = @event.event_submissions.new
  end

  def create
    sp = submission_params
    sp[:submitter_id] = @current_user.id
    @submission = EventSubmission.create(sp)
    redirect_to @submission.event_registration
  end

  private

  def find_event
    @event = @current_user.events.find(params[:event_id])
  end

  def find_submission
    @submission = EventSubmission.find(params[:id])
  end

  def submission_params
    params.require(:event_submission).permit(:event_requirement_id, :event_registration_id, :file)
  end
end
