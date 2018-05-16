class EventRegistrationsController < AuthenticatedController
  before_action :find_registration

  def show
    # TODO: pundit this
  end

  private

  def find_registration
    @registration = EventRegistration.find(params[:id])
  end
end
