class AchievementsController < UnitContextController
  before_action :find_user
  before_action :find_achievement, except: [:index, :new, :create]

  def index
    @next_rank = Rank.find_by(name: 'Second Class')
  end

  def new
  end

  def create
    @achievement = @user.achievements.new(achievement_params)
    if @achievement.save
      respond_to do |format|
        format.html do
          flash[:notice] = I18n.t('advancement.success.merit_badge', name: @user.first_name, badge: @achievement.achievable.name)
          redirect_to unit_membership_achievements_path(@unit, @membership) unless request.xhr?
        end
        format.json { render json: @achievement }
      end
    else
    end
  end

  def destroy
    @achievement.destroy
    respond_to do |format|
      format.json { render json: {}, status: :deleted }
    end
  end

  private

  def achievement_params
    params.require(:achievement).permit(:achievable_id)
  end

  def find_achievement
    @achievement = @user.achievements.find(params[:id])
  end

  def find_user
    @membership = @unit.memberships.find(params[:membership_id])
    @user = @membership.user
  end
end
