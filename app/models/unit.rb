class Unit < ApplicationRecord
  has_many :events
  has_many :event_registrations, through: :events
  has_many :memberships
  has_many :members, through: :memberships, source: 'user'
  validates_presence_of :number, :location
  validates_uniqueness_of :location, scope: :number

  def role(user)
    memberships.where(user: user)&.first&.role
  end
end
