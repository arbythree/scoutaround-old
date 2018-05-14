class EventRequirement < ApplicationRecord
  belongs_to :event
  has_one :attachment
  has_many :event_submissions

  def completed_for?(person)
    false
  end
end
