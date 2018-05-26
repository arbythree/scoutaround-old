# a handful of controllers rely on @event being set. This base controller
# takes care of that (and, by virtue of inheriting from UnitContextController,
# also sets @unit)

class EventsController < UnitContextController
  before_action :find_event, except: [:index, :new, :create]

  def index
    @events = @unit.present? ? @unit.events.future : @current_user.events.future
  end

  def show
  end

  def edit
    # TODO: pundit this
  end

  def new
    @event = Event.new
    @event.starts_at = 6.weeks.from_now
    @event.ends_at   = 6.weeks.from_now
  end

  def create
    @event = @unit.events.new(event_params)
    if @event.save
      flash[:notice] = t('events.confirm')
      redirect_to unit_events_path(@unit)
    end
  end

  def update
    redirect_to @event if @event.update_attributes(event_params)
  end

  def find_event
    @event = @current_user.events.find(params[:id] || params[:event_id])
    @membership = Membership.where(user: @current_user, unit: @event.unit).first
  end

  def event_params
    params.require(:event).permit(:name, :location, :starts_at, :ends_at)
  end
end
