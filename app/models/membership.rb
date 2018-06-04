class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :unit
  belongs_to :unit_position, optional: true

  validates_uniqueness_of :user, scope: :unit
  enum role: {
    normal: 0,
    admin: 1,
  }
  scope :active, -> { where(active: true) }
  scope :admins, -> { where(role: :admin) }

  accepts_nested_attributes_for :user
end
