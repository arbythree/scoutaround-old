class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :unit
  validates_uniqueness_of :user, scope: :unit
  enum role: {
    normal: 0,
    admin: 1,
  }
  scope :active, -> { where(active: true) }
  scope :admins, -> { where(role: :admin) }
end
