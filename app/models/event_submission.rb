class EventSubmission < ApplicationRecord
  # encrypted_id key: 'c055cafa7225635b'
  belongs_to :event_requirement
  belongs_to :registration
  belongs_to :approver, class_name: 'Person', optional: true
  belongs_to :submitter, class_name: 'Person'
  validates_uniqueness_of :event_requirement, scope: :registration
  scope :unapproved, -> { where('approved_at IS NULL') }
  delegate :person, to: :registration
  delegate :event, to: :event_requirement

  def approved?
    approved_at.present?
  end
end
