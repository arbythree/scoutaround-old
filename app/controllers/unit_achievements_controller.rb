class UnitAchievementsController < AuthenticatedController
  before_action :find_unit

  def index
  end

  private

  def find_unit
    @unit = @current_user.units.find(params[:unit_id])
  end
end
