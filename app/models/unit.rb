class Unit < ApplicationRecord
  has_many :events
  has_many :memberships
  has_many :members, through: :memberships, source: 'person'
  validates_presence_of :number, :location
end
