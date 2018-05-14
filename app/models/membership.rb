class Membership < ApplicationRecord
  belongs_to :person
  belongs_to :unit
  validates_uniqueness_of :person, scope: :unit
  enum role: {
    normal: 0,
    admin: 1,
  }
  scope :active, -> { where(active: true) }
end
