class SubmissionsController < AuthenticatedController
  before_action :find_submission, except: [:new, :create, :index]

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

  def find_submission
    @submission = EventSubmission.find(params[:id])
  end

  def submission_params
    params.require(:event_submission).permit(:event_requirement_id, :event_registration_id, :file)
  end
end
