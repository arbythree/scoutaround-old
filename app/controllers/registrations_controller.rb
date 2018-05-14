class RegistrationsController < AuthenticatedController
  before_action :find_registration

  def show
  end

  private

  def find_registration
    @registration = @current_person.registrations.find(params[:id])
  end
end
