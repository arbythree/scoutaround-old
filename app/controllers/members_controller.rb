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


    ap show

    if show.include? 'inactive'
      @memberships = @unit.memberships.includes(:person).order('people.first_name')
    else
      @memberships = @unit.memberships.active.includes(:person).order('people.first_name')
    end

    @memberships = @memberships.select { |m| m.person.type == 'Adult' } if show.include? 'adults'
    @memberships = @memberships.select { |m| m.person.type == 'Youth' } if show.include? 'youths'

    @members = @memberships.map { |m| m.person }
  end    

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
