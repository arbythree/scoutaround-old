class Unit < ApplicationRecord
  has_many :events
  has_many :event_registrations, through: :events
  has_many :memberships
  has_many :members, through: :memberships, source: 'user'
  has_many :document_library_items
  has_many :achievements, through: :users
  validates_presence_of :number, :location
  validates_uniqueness_of :location, scope: :number

  def role_for(user: nil)
    memberships.where(user: user)&.first&.role
  end

  def ranks
    Rank.where(program_code: self.program_code).order(:ordinal)
  end
end
