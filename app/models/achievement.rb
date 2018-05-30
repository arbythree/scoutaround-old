class Achievement < ApplicationRecord
  belongs_to :user
  belongs_to :achievable
  validates_uniqueness_of :user, scope: :achievable
end
