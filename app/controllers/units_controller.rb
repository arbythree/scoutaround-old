class UnitsController < AuthenticatedController
  before_action :find_unit

  def show
    redirect_to unit_events_path(@unit)
  end

  private

  def find_unit
    @unit = @current_person.units.find(params[:id])
  end
end
