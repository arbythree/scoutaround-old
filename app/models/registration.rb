class Registration < ApplicationRecord
  belongs_to :person
  belongs_to :event

  def completed_by?(person)
    completions = event.event_requirements.map { |r| r.completed_by?(person) }
    !completions.include? false
  end
end
