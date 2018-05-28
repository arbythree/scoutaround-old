class Event < ApplicationRecord
  # encrypted_id key: 'c055cafa7225635b'
  belongs_to :unit
  has_many :event_registrations
  has_many :registrants, through: :event_registrations, source: :user
  has_many :event_submissions, through: :event_registrations
  has_many :event_requirements
  has_many :messages, as: :messagable
  has_many :event_submissions, through: :event_registrations

  validates_presence_of :name
  scope :future, -> { where('ends_at > ?', Date.today) }

  def registered_for?(user)
    registrations.exists?(user_id: user.id)
  end

  def non_registrants
    unit.members - registrants
  end
end
