class EventRegistrationsController < AuthenticatedController
  include ApplicationHelper
  before_action :find_unit
  before_action :find_event
  before_action :find_registration, except: [:index, :new, :create]

  def index

  end

  def show
    # TODO: pundit this
  end

  def new
  end

  def create

    users = @unit.members.find(params['event']['registrant_ids'])

    users.each do |user|
      @event.event_registrations.create(user: user)
    end

    flash[:notice] = "Registered #{ user_synopsis(users) }"

    redirect_to unit_event_event_registrations_path(@unit, @event)
  end

  def update
  end

  def destroy
    user = @registration.user
    @registration.destroy
    flash[:notice] = "Unregistered #{ user.full_name }"
    redirect_to unit_event_event_registrations_path(@unit, @event)
  end

  private

  def find_unit
    @unit = @current_user.units.find(params[:unit_id])
  end

  def find_event
    @event = @current_user.events.find(params[:event_id])
  end

  def find_registration
    @registration = @event.event_registrations.find(params[:id])
  end
end
