class EventRegistration < ApplicationRecord
  belongs_to :person
  belongs_to :event
  has_many :event_submissions
  validates_uniqueness_of :person, scope: :event
  delegate :full_name, to: :person

  def completed_for?(person)
    completions = event.event_requirements.map { |r| r.completed_for?(person) }
    !completions.include? false
  end
end
