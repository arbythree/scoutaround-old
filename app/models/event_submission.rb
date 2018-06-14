class EventSubmission < ApplicationRecord
  belongs_to :event_requirement
  belongs_to :event_registration
  belongs_to :approver, class_name: 'User', optional: true
  belongs_to :submitter, class_name: 'User'
  validates_uniqueness_of :event_requirement, scope: :event_registration # don't allow dupes
  validates_presence_of :event_requirement
  validates_presence_of :event_registration
  scope :unapproved, -> { where('approved_at IS NULL') }
  delegate :user, to: :event_registration
  delegate :event,  to: :event_registration
  has_one_attached :attachment

  def approved?
    # approved_at.present?
    true
  end
end
