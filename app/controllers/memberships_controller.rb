class MembershipsController < UnitContextController
  before_action :find_member, except: [:index, :new, :create]
  before_action :find_unit

  def index
    @body_classes = ['hide-none']
    @memberships = @unit.memberships.includes(:user).order('users.first_name')
    @members = @memberships.map { |m| m.user }

    respond_to do |format|
      format.html
      format.csv { send_data @memberships.to_csv, filename: "#{@unit.type}-#{@unit.number}-#{Date.today}.csv" }
    end
  end

  def show
    @registrations = @unit.event_registrations.where(user_id: @membership.user_id)
  end

  def new
    @membership = @unit.memberships.build
    @user = @membership.build_user
    @user.type = (params[:type] || 'youth').titleize
    @eligible_positions = UnitPosition.where(program_code: @unit.program_code, audience: @user.type.downcase)
  end

  def create
    @membership = @unit.memberships.new(membership_params)
    @membership.user.email = "anonymous_#{ SecureRandom.hex(12) }@scoutaround.org" if @membership.user.email.empty?
    @membership.user.password = SecureRandom.hex(12)
    if @membership.save
      flash[:notice] = t('memberships.new.confirm', full_name: @membership.user.full_name)
      redirect_to unit_memberships_path(@unit)
      return
    end

    redirect_to new_unit_membership_path(@unit)
  end

  def update
    @membership.assign_attributes(membership_params)
    @membership.user.email = @user.email if @user.anonymous_email? && @membership.user.email.empty?
    @membership.user.email = "anonymous_#{ SecureRandom.hex(12) }@scoutaround.org" if @membership.user.email.empty?

    if @membership.save
      flash[:notice] = t('memberships.updated', full_name: @membership.user.full_name)
      redirect_to membership_path(@unit, @membership)
    else
      redirect_to edit_membership_path(@membership)
    end
  end

  def edit
    @eligible_positions = UnitPosition.where(program_code: @unit.program_code, audience: @membership.user.type.downcase)
  end

  private

  def find_member
    @membership = Membership.includes(:user).find(params[:id])
    # @membership = @unit.memberships.includes(:user).find(params[:id])
    @user = @membership.user
  end

  def find_unit
    @unit = Unit.find(params[:unit_id]) if params[:unit_id].present?
    @unit = @membership.unit if @membership.present?
    @current_user_is_admin = @unit.role_for(user: @current_user) == 'admin'
  end

  def membership_params
    params.require(:membership).permit(
      :unit_position_id,
      user_attributes: [:id, :rank_id, :first_name, :last_name,
        :nickname, :type, :email, :phone, :avatar,
        guardeeships_attributes: [:id, :guardian_id, :_destroy]
      ]
    )
  end
end
