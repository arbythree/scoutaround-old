class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :rank, optional: true
  has_many :memberships
  has_many :units, through: :memberships
  has_many :event_registrations
  has_many :registered_events, through: :event_registrations, class_name: 'Event'
  has_many :events, through: :units
  has_many :achievements
  has_many :merit_badges, -> { where(type: 'MeritBadge') }, through: :achievements, source: :achievable
  has_one_attached :avatar

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

  accepts_nested_attributes_for :guardeeships, reject_if: :all_blank, allow_destroy: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def short_name
    "#{first_name} #{last_name[0]}"
  end

  def initials
    "#{first_name[0]} #{last_name[0]}"
  end

  def multiple_units?
    units.count > 1
  end

  def anonymous_email?
    email =~ /anonymous_.*@scoutaround.org/
  end

  def family
    [self].concat(self.guardees)
  end

  def is_member_of?(unit: nil)
    return false unless unit.present?
    unit.memberships.exists?(user_id: self.id)
  end
end
