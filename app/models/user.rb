class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships
  has_many :units, through: :memberships
  has_many :event_registrations
  has_many :events, through: :units
  validates_presence_of :first_name, :last_name

  def full_name
    "#{first_name} #{last_name}"
  end

  def multiple_units?
    units.count > 1
  end
end
