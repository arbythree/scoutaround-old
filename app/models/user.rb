class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships
  has_many :units, through: :memberships
  has_many :event_registrations
  has_many :registered_events, through: :event_registrations, class_name: 'Event'
  has_many :events, through: :units

  #
  # let's pause here for a second. This is complicated.
  # A Guardianship is a join model for a many-to-many relationship
  # between Users
  #
  has_many :guardianships, foreign_key: 'guardian_id'
  has_many :guardees, through: :guardianships
  has_many :guardeeships, class_name: 'Guardianship', foreign_key: 'guardee_id'
  has_many :guardians, through: :guardeeships

  validates_presence_of :first_name, :last_name, :type

  accepts_nested_attributes_for :guardians

  def full_name
    "#{first_name} #{last_name}"
  end

  def multiple_units?
    units.count > 1
  end
end
