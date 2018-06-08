class EventRequirements::EventSubmissionsController < EventSubmissionsController
  before_action :find_event_requirement
  before_action :find_event
  before_action :find_unit

  private

  def find_event_requirement
    @event_requirement = EventRequirement.includes(:event).find(params[:event_requirement_id])
  end

  def find_event
    @event = @event_requirement.event
  end

  def find_unit
    @unit = @event.unit
  end
end
