class Units::AchievementsController < AuthenticatedController
  before_action :find_unit

  def index
  end

  private

  def find_unit
    @unit = @current_user.units.find(params[:unit_id])
    @current_user_is_admin = @unit.role_for(user: @current_user) == 'admin'
  end
end
