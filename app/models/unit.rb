class Unit < ApplicationRecord
  has_many :events
  has_many :memberships
  has_many :people, through: :memberships
end
