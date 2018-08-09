class Units::EventSubmissionsController < EventSubmissionsController
  # before_action :find_event_requirement
  # before_action :find_event

  include UnitContext

  # def find_event_requirement
  #   @event_requirement = EventRequirement.find(params[:event_requirement_id])
  # end

  # def find_event
  #   @event = @event_requirement.event
  # end
end
