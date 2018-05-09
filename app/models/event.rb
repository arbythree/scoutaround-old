class Event < ApplicationRecord
  belongs_to :unit
  has_many :registrations
  has_many :people, through: :registrations
  has_many :event_requirements
  has_many :attachments, as: :attachable

  def registered_for?(person)
    registrations.exists?(person_id: id)
  end
end
