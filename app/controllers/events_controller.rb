# a handful of controllers rely on @event being set. This base controller
# takes care of that (and, by virtue of inheriting from UnitContextController,
# also sets @unit)

class EventsController < UnitContextController
  before_action :find_event, except: [:index, :new, :create]
  layout :choose_layout

  def choose_layout
    'application'
  end

  def index
    @events = @unit.present? ? @unit.events.future.order(:starts_at) : @current_user.events.future.order(:starts_at)
    @tracking_properties = { view: @view }

    # this is bound to be inefficient, but let's get it working first
    if params[:filter] == 'registered'
      @events = @events.reject do |event|
        family_registrants = []

        @current_user.family.each do |user|
          family_registrants << user if event.registered_for?(user: user)
        end

        family_registrants.count.zero?
      end
    end

    respond_to do |format|
      format.html
      format.ics { render layout: false }
    end
  end

  def show
    @registrations = @event.event_registrations.includes(:user).order('users.first_name', 'users.last_name')
  end

  def edit
    # TODO: pundit this
  end

  def new
    @event = Event.new
    @event.starts_at = 6.weeks.from_now
    @event.ends_at   = 6.weeks.from_now
    @event.registration_closes_at = 5.weeks.from_now
  end

  def create
    @event = @unit.events.new(event_params)

    if params[:starts_at_time].present?
      starts_at = Time.parse(params[:starts_at_time])
      ends_at = Time.parse(params[:ends_at_time])
      @event.starts_at = @event.starts_at.change({ hour: starts_at.hour, min: starts_at.min })
      @event.ends_at = @event.ends_at.change({ hour: ends_at.hour, min: ends_at.min })
    end

    if @event.save
      repeat_until = Date.parse(params[:repeat_until])

      if params[:repeat] != 'never'
        current_start_date = @event.starts_at
        current_end_date = @event.ends_at

        until current_start_date > repeat_until do
          # weekly is the only repeat option, so just add a week
          current_start_date += 1.week
          current_end_date += 1.week

          # instantiate a new event
          event = @unit.events.new(event_params)
          event.starts_at = current_start_date
          event.ends_at = current_end_date

          # save it
          event.save
        end
      end

      flash[:notice] = t('events.confirm')
      redirect_to unit_events_path(@unit)
    end
  end

  def update
    if @event.update_attributes(event_params)
      redirect_to event_path(@event)
    else
      redirect_to edit_event_path(@event)
    end
  end

  def destroy
    @event.destroy
    flash[:notice] = t('events.confirmations.cancel')
    redirect_to unit_events_path(@unit)
  end

  private

  def find_event
    @event = @current_user.events.find(params[:id] || params[:event_id])
    @unit = @event.unit
    @current_user_is_admin = @unit.role_for(user: @current_user) == 'admin'
    @membership = Membership.where(user: @current_user, unit: @event.unit).first
  end

  def event_params
    params.require(:event).permit(:name, :location, :starts_at, :ends_at, :require_registration, :registration_closes_at)
  end
end
