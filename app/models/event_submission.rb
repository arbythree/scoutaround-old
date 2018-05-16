class EventSubmission < ApplicationRecord
  belongs_to :event_requirement
  belongs_to :event_registration
  belongs_to :approver, class_name: 'Person', optional: true
  belongs_to :submitter, class_name: 'Person'
  validates_uniqueness_of :event_requirement, scope: :event_registration # don't allow dupes
  scope :unapproved, -> { where('approved_at IS NULL') }
  delegate :person, to: :event_registration
  delegate :event,  to: :event_registration
  include AttachmentUploader.attachment(:file)

  def approved?
    approved_at.present?
  end
end
