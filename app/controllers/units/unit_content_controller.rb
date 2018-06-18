class Units::UnitContextController < AuthenticatedController
  before_action :find_unit

  private

  def find_unit
    @unit = Unit.find(params[:unit_id])
  end
end
