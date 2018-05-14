class MembersController < AuthenticatedController
  before_action :find_unit

  def index
    if (params[:show] || '').split(',').include? 'inactive'
      @memberships = @unit.memberships
    else
      @memberships = @unit.memberships.active
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

  private

  def find_unit
    @unit = @current_person.units.find(params[:unit_id])
  end

  def member_params
    params.require(:person).permit(:first_name, :last_name, :email, :phone)
  end
end
