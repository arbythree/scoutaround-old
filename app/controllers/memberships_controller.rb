class MembershipsController < AuthenticatedController
  before_action :find_unit
  before_action :find_member, except: [:index, :new, :create]

  def index
    @memberships = @unit.memberships.includes(:user).order('users.first_name')
    @members = @memberships.map { |m| m.user }
  end

  def show
    @registrations = @unit.event_registrations.where(user_id: @member.id)
  end

  def new
    @membership = @unit.memberships.build
    @membership.build_user
  end

  def create
    @membership = @unit.memberships.new(membership_params)
    @membership.user.email = "anonymous_#{ SecureRandom.hex(12) }@scoutaround.org" if @membership.user.email.empty?
    @membership.user.password = SecureRandom.hex(12)
    if @membership.save
      flash[:notice] = t('memberships.new.confirm', full_name: @membership.user.full_name)
      redirect_to unit_memberships_path(@unit)
    else
      redirect_to new_unit_membership_path(@unit)
    end
  end

  private

  def find_unit
    @unit = @current_user.units.find(params[:unit_id])
  end

  def find_member
    @membership = @unit.memberships.find(params[:id])
    @member = @membership.user
  end

  def membership_params
    params.require(:membership).permit(user_attributes: [:first_name, :last_name, :type, :email, :phone])
  end
end
