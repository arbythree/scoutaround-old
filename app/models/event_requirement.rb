class EventRequirement < ApplicationRecord
  belongs_to :event
  has_one :attachment
  has_many :event_submissions

  def completed_for?(person)
    registration = event.event_registrations.find_by(person: person)
    event_submissions.exists?(event_registration: registration)
  end
end
