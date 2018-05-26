class EventRequirementsController < EventContextController
  def new
    @requirement = @event.event_requirements.new
    @requirement.due_at = @event.starts_at - 1.week
  end

  def create
    @requirement = @event.event_requirements.new(event_requirement_params)
    if @requirement.save
      redirect_to unit_event_event_registrations_path(@unit, @event)
      return
    end

    redirect_to new_unit_event_event_requirement_path(@unit, @event)
  end

  private

  def event_requirement_params
    params.require(:event_requirement).permit(:description, :due_at, :type)
  end
end
