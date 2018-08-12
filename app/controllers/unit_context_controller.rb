class UnitContextController < AuthenticatedController
  before_action :find_unit

  def find_unit
    @unit = @current_user.units.find(params[:unit_id])
    @membership = @unit.membership_for(user: @current_user)
    @current_user_is_admin = (@membership.role == 'admin')
  end
end
