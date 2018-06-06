class EventRequirementsController < EventContextController
  before_action :find_event_requirement, except: [:index, :new, :create]

  def new
    @event_requirement = @event.event_requirements.new
    @event_requirement.due_at = @event.starts_at - 1.week
    @event_requirement.audience = 'everyone'
  end

  def create
    @event_requirement = @event.event_requirements.new(event_requirement_params)

    if @event_requirement.save
      redirect_to unit_event_event_registrations_path(@unit, @event)
      return
    end

    redirect_to new_unit_event_event_requirement_path(@unit, @event)
  end

  def edit
  end

  def update
    @event_requirement.assign_attributes(event_requirement_params)
    if @event_requirement.save
      flash[:notice] = 'event_requirements.confirm_update'
      redirect_to unit_event_event_registrations_path(@unit, @event)
    else
      redirect_to unit_event_event_requirement_path(@unit, @event, @event_requirement)
    end
  end

  private

  def event_requirement_params
    params.require(:event_requirement).permit(:description, :due_at, :type, :document_library_item_id, :audience, :required, :amount_youth, :amount_adult)
  end

  def find_event_requirement
    @event_requirement = @event.event_requirements.find(params[:id])
  end
end
