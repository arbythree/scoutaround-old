class EventRegistrationPresenter < BasePresenter
  presents :event_registration

  def event_name
    event_registration.event.name
  end

  def person_name
    "#{event_registration.person.first_name} #{event_registration.person.last_name}"
  end
end
