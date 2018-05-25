class EventRequirement < ApplicationRecord
  belongs_to :event
  has_many :event_submissions

  def completed_for?(user)
    registration = event.event_registrations.find_by(user: user)
    event_submissions.exists?(event_registration: registration)
  end
end
