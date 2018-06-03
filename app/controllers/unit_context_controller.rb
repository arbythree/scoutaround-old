class UnitContextController < AuthenticatedController
  before_action :find_unit

  def find_unit
    unit_id = controller_name == 'units' ? params[:id] : params[:unit_id]
    return unless unit_id.present?
    @unit = @current_user.units.find(unit_id)
    @current_user_is_admin = @unit.role_for(user: @current_user) == 'admin'
  end
end
