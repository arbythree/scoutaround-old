class EventRequirement < ApplicationRecord
  belongs_to :event
  has_one :attachment

  def completed_by?(person)
    false
  end
end
