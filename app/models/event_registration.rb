class EventRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :event_submissions
  validates_presence_of :user, :event # don't allow empties
  validates_uniqueness_of :user, scope: :event # prevent duplicate registrations
  delegate :full_name, to: :user

  def completed?
    completions = event.event_requirements.map { |r| r.completed_for?(user: self.user) }
    !completions.include? false
  end

  def self.completed
    result = self.all.select { |registration| registration.completed? }
  end
end
