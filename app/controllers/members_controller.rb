class MembersController < AuthenticatedController
  before_action :find_unit
  before_action :find_member, only: :show

  def index
    if (params[:show] || '').split(',').include? 'inactive'
      @memberships = @unit.memberships.includes(:person).order('people.first_name')
    else
      @memberships = @unit.memberships.active.includes(:person).order('people.first_name')
    end
    @members = @memberships.map { |m| m.person }
  end

  def new
    @member = @unit.members.new
  end

  def create
    if @member = @unit.members.create(member_params)
      flash[:notice] = t('members.added')
      redirect_to unit_members_path(@unit)
    end
  end

  def show
  end

  private

  def find_unit
    @unit = @current_person.units.find(params[:unit_id])
  end

  def find_member
    @member = @unit.members.find(params[:id])
  end

  def member_params
    params.require(:person).permit(:first_name, :last_name, :email, :phone)
  end
end
