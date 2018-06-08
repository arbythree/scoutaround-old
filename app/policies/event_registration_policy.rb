class EventRegistrationPolicy < ApplicationPolicy
  attr_reader :user, :event_registration

  def initialize(user, event_registration)
    @user = user
    @event_registration = event_registration
  end

  def index?
    @event_registration.event.unit.role_for(user: user) == 'admin'
  end

  def show?
    @event_registration.event.unit.role_for(user: user) == 'admin'
  end
end
