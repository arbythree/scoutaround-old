class EventRequirement < ApplicationRecord
  belongs_to :event
  has_many :event_submissions

  def completed_for?(user: nil)
    return unless user.present?
    registration = event.event_registrations.find_by(user: user)
    return unless registration.present?
    event_submissions.exists?(event_registration: registration)
  end
end
