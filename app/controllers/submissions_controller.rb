class SubmissionsController < AuthenticatedController
  before_action :find_submission, except: :new

  def show
    # TODO: pundit this
  end

  def new
    @event = Event.find(params[:event_id])
    @submission = @event.event_submissions.new
  end

  private
  def find_submission
    @submission = EventSubmission.find(params[:id])
  end
end
