class EventRequirements::EventSubmissionsController < EventSubmissionsController
  before_action :find_event

  private

  def find_event
    @event = Event.find(params[:event_id])
  end
end
