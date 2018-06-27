module UnitContext
  extend ActiveSupport::Concern

  included do
    before_action :find_unit
  end

  def find_unit
    @unit = Unit.find(params[:unit_id])
    @current_membership = @unit.memberships.find_by(user: @current_user)
    @current_user_is_admin = @current_membership.role == 'admin'
  end
end
