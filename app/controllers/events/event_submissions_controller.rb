class Events::EventSubmissionsController < EventSubmissionsController
  before_action :find_event
  before_action :find_unit
  before_action :find_current_user_unit_role

  def new
    @submission = EventSubmission.new

    # iterate through all event registrations and determine whether current user is allowed to
    # submit on behalf of that user. Admins can submit on behalf of anyone. Users can always submit
    # on their own behalf. Guardian can submit on behalf of their guardees. All others are prohibited.
    # TODO: extract this
    @visible_event_registrations = []
    @event.event_registrations.each do |registration|
      if @current_user_is_admin
        @visible_event_registrations << registration
      elsif registration.user == @current_user
        @visible_event_registrations << registration
      elsif @current_user.guardees.include? registration.user
        @visible_event_registrations << registration
      else
        # nope
      end
    end
  end

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
