class EventSubmission < ApplicationRecord
  belongs_to :event_requirement
  belongs_to :registration
  belongs_to :approver, class_name: 'Person', optional: true
  belongs_to :submitter, class_name: 'Person'
  validates_uniqueness_of :event_requirement, scope: :registration
  scope :unapproved, -> { where('approved_at IS NULL') }

  def person
    registration.person
  end

  def event
    event_requirement.event
  end

  def approved?
    approved_at.present?
  end
end
