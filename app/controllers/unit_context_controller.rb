class UnitContextController < AuthenticatedController
  before_action :find_unit

  def find_unit
    return unless params[:unit_id].present?
    logger.info "Current user is #{ @current_user }"
    @unit = @current_user.units.find(params[:unit_id])
    @current_user_is_admin = @unit.role_for(user: @current_user) == 'admin'
  end
end
