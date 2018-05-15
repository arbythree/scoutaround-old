class Event < ApplicationRecord
  # encrypted_id key: 'c055cafa7225635b'
  belongs_to :unit
  has_many :event_registrations
  has_many :registrants, through: :event_registrations, source: :person
  has_many :event_submissions, through: :event_registrations
  has_many :event_requirements
  has_many :attachments, as: :attachable
  has_many :event_submissions, through: :event_registrations
  validates_presence_of :name
  scope :future, -> { where('ends_at > ?', Date.today) }

  def registered_for?(person)
    registrations.exists?(person_id: person.id)
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
