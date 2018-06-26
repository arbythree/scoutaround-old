class Units::AchievementsController < AuthenticatedController
  before_action :find_unit
  before_action :find_achievement, except: [:index]

  def index
  end

  def destroy
    @achievement.destroy
  end

  private

  def find_unit
    @unit = @current_user.units.find(params[:unit_id])
    @membership = @unit.membership_for(user: @current_user)
    @current_user_is_admin = @membership.role == 'admin'
  end

  def find_achievement
    @achievement = Achievement.find(params[:id])
  end
end
