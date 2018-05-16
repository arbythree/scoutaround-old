class EventRegistrationsController < AuthenticatedController
  before_action :find_event
  before_action :find_registration, except: [:index]

  def index

  end

  def show
    # TODO: pundit this
  end

  private

  def find_event
    @event = @current_user.events.find(params[:event_id])
  end

  def find_registration
    @registration = @event.event_registrations.find(params[:id])
  end
end
