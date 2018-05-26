class EventRegistrationsController < EventContextController
  include ApplicationHelper
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

  def find_registration
    @registration = @event.event_registrations.find(params[:id])
  end
end
