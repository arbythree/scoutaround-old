class EventRequirement < ApplicationRecord
  belongs_to :event
  has_one :attachment
  has_many :event_submissions

  def completed_for?(person)
    registration = event.registrations.find_by(person: person)
    event_submissions.exists?(registration: registration)
  end
end
