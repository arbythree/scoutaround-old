class EventRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :event_submissions
  validates_presence_of :user, :event # don't allow empties
  validates_uniqueness_of :user, scope: :event # prevent duplicate registrations
  delegate :full_name, to: :user

  def completed?
    completions = event.event_requirements.map { |requirement| requirement.completed_for?(user: self.user) }
    !completions.include? false
  end

  # return the set of completed EventRegistrations
  def self.completed
    result = self.all.select { |registration| registration.completed? }
  end
end
