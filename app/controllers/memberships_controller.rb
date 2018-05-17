class MembershipsController < AuthenticatedController
  before_action :find_unit
  before_action :find_member, except: [:index]

  def index
    @memberships = @unit.memberships
    @members = @memberships.map { |m| m.user }
  end

  def show
    @registrations = @unit.event_registrations.where(user_id: @member.id)
  end

  private

  def find_unit
    @unit = @current_user.units.find(params[:unit_id])
  end

  def find_member
    @membership = @unit.memberships.find(params[:id])
    @member = @membership.user
  end
end
