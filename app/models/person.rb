class Person < ApplicationRecord
  has_many :memberships
  has_many :units, through: :memberships
  has_many :registrations
  has_many :events, through: :units
  has_one :user
end
