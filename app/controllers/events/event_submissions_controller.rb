class Events::EventSubmissionsController < EventSubmissionsController
  before_action :find_event
  before_action :find_unit
  before_action :find_current_user_unit_role

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_unit
    @unit = @event.unit
  end

  def find_current_user_unit_role
    @unit_role = @unit.role_for(user: @current_user)
    @current_user_is_admin = (@unit_role == 'admin')
  end
end
