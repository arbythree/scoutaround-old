class EventsController < AuthenticatedController
  before_action :find_unit
  before_action :find_event, except: :index

  def index
    @events = @unit.present? ? @unit.events : @current_person.events
  end

  def show
  end

  def info
    # TODO: pundit this
  end

  def edit
    # TODO: pundit this
  end

  def update
    redirect_to @event if @event.update_attributes(event_params)
  end

  private

  def find_unit
    return unless params[:unit_id].present?
    @unit = @current_person.units.find(params[:unit_id])
  end

  def find_event
    @current_person = current_user.person
    @event = @current_person.events.find(params[:id] || params[:event_id])
    @membership = Membership.where(person: @current_person, unit: @event.unit).first
  end

  def event_params
    params.require(:event).permit(:location, :starts_at, :ends_at)
  end
end
