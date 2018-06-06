class EventRegistrationsController < EventContextController
  include ApplicationHelper
  before_action :find_registration, except: [:index, :new, :create]

  def index
    authorize EventRegistration.new(event: @event)
    @body_classes = ['admin']
  end

  def show
    # TODO: pundit this
  end

  def new
  end

  def create
    if params[:user].present?
      perform_single_registration
    elsif params['event']['registrant_ids'].present?
      perform_bulk_registration
    end
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

  def perform_single_registration
    user = @unit.members.find(params[:user])
    @registration = @event.event_registrations.create(user: user)
    flash[:notice] = I18n.t('event_registrations.success.created.single', user_name: user.first_name, event_name: @event.name)
    redirect_to unit_event_event_registration_path(@unit, @event, @registration)
  end

  def perform_bulk_registration
    users = @unit.members.find(params['event']['registrant_ids'])
    users.each do |user|
      @event.event_registrations.create(user: user)
    end

    flash[:notice] = "Registered #{ user_synopsis(users) }"
    redirect_to unit_event_event_registrations_path(@unit, @event)
  end

  def find_registration
    @registration = @event.event_registrations.find(params[:id])
  end
end
