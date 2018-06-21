class AchievementsController < AuthenticatedController
  before_action :find_achievement, except: [:index, :new, :create]
  before_action :find_membership
  before_action :find_unit

  def index
    @next_rank = @user&.rank&.next_rank || Rank.find_by(ordinal: 0)
  end

  def new
  end

  def create
    @achievement = @user.achievements.new(achievement_params)
    if @achievement.save
      respond_to do |format|
        format.html do
          flash[:notice] = I18n.t('advancement.success.merit_badge', name: @user.first_name, badge: @achievement.achievable.name)
          redirect_to membership_achievements_path(@membership) unless request.xhr?
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
    @achievement = Achievement.find(params[:id])
  end

  def find_membership
    if params[:membership_id].present?
      @membership = Membership.find(params[:membership_id])
      @user = @membership.user
    end
  end

  def find_unit
    if params[:unit_id].present?
      @unit = @current_user.users.find(params[:unit_id])
    elsif @membership.present?
      @unit = @membership.unit
    end

    @current_user_is_admin = @unit.role_for(user: @current_user) == 'admin'
  end
end
