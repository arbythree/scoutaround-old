class AchievementsController < UnitContextController
  before_action :find_user

  def index
    @next_rank = 'Second Class'
  end

  def new
  end

  def create
    @achievement = @user.achievements.new(achievement_params)
    if @achievement.save
      flash[:notice] = I18n.t('advancement.success.merit_badge', name: @user.first_name, badge: @achievement.achievable.name)
      redirect_to unit_membership_achievements_path(@unit, @membership)
    else
    end
  end

  private

  def achievement_params
    params.require(:achievement).permit(:achievable_id)
  end

  def find_user
    @membership = @unit.memberships.find(params[:membership_id])
    @user = @membership.user
  end
end
