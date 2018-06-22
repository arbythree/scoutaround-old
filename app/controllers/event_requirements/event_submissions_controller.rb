class EventRequirements::EventSubmissionsController < EventSubmissionsController
  before_action :find_event_requirement
  before_action :find_event
  before_action :find_unit

  def new
    @submission = @event_requirement.event_submissions.new(event_registration_id: params[:registration])

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

  private

  def find_event_requirement
    @event_requirement = EventRequirement.includes(:event).find(params[:event_requirement_id])
  end

  def find_event
    @event = @event_requirement.event
  end

  def find_unit
    @unit = @event.unit
    @current_user_is_admin = @unit.role_for(user: @current_user) == 'admin'
  end
end
