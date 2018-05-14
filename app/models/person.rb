class Person < ApplicationRecord
  has_many :memberships
  has_many :units, through: :memberships
  has_many :registrations
  has_many :events, through: :units
  has_one :user
  validates_presence_of :first_name, :last_name

  def full_name
    "#{first_name} #{last_name}"
  end

  def multiple_units?
    units.count > 1
  end
end
