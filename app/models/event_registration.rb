class EventRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :event_submissions
  validates_uniqueness_of :user, scope: :event # prevent duplicate registrations
  delegate :full_name, to: :user

  def completed_for?(user)
    completions = event.event_requirements.map { |r| r.completed_for?(user) }
    !completions.include? false
  end
end
