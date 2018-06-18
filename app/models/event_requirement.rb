class EventRequirement < ApplicationRecord
  belongs_to :event
  belongs_to :document_library_item, optional: true
  has_many :event_submissions
  has_many :magic_links, as: :magic_linkable
  enum audience: {
    everyone: 0,
    youth_only: 1,
    adult_only: 2
  }

  def completed_by?(user: nil)
    return false unless user.present?

    # if this requirement isn't needed for the user under consideration, then
    # it's de-facto completed, so return true
    return true unless required_for?(user: user)

    # resolve the user's registration...
    registration = event.event_registrations.find_by(user: user)
    return false unless registration.present?

    # ...and then see if there's a submission
    event_submissions.exists?(event_registration: registration)
  end

  def required_for?(user: nil)
    return false unless user.present?
    return true if audience == 'everyone'
    return true if audience == 'adult_only' && user.is_a?(Adult)
    return true if audience == 'youth_only' && user.is_a?(Youth)
    return false
  end

  def to_s
    "#{ self.event.name } #{ self.description }"
  end
end
