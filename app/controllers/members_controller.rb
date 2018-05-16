class MembersController < AuthenticatedController
  before_action :find_unit
  before_action :find_member, only: [:show]
  before_action :find_members, only: [:index, :roster]

  def index
  end

  def new
    @member = @unit.members.new
  end

  def create
    parameters = member_params
    parameters[:email]    = "anonymous_SecureRandom.hex(12)@scoutaround.org" if parameters[:email].blank?
    parameters[:password] = Devise.friendly_token.first(8)
    if @member = @unit.members.create(member_params)
      flash[:notice] = t('members.added')
      redirect_to unit_members_path(@unit)
    end
  end

  def show
  end

  def roster
    render 'members/_roster', layout: false
  end

  private

  def find_members
    show = (params[:show] || '').split(',')
    @memberships = @unit.memberships.includes(:user).order('users.first_name')
    @members = @memberships.map { |m| m.user }
  end

  def find_unit
    @unit = @current_user.units.find(params[:unit_id])
  end

  def find_member
    @member = @unit.members.find(params[:id])
  end

  def member_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone)
  end
end
