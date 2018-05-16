class EventRegistrationPresenter < BasePresenter
  presents :event_registration

  def event_name
    event_registration.event.name
  end

  def registrant_name
    "#{event_registration.user.full_name}"
  end
end
