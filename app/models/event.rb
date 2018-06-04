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
  scope :future, -> { where('ends_at >= ?', Date.today) }
  scope :upcoming, -> { where('starts_at > ? AND starts_at < ?', Date.today, 4.weeks.from_now).order(:starts_at) }

  def registered_for?(user: nil)
    event_registrations.exists?(user_id: user.id)
  end

  def non_registrants
    unit.members - registrants
  end

  def duration_in_days
    (ends_at - starts_at) / 1.day
  end
end
