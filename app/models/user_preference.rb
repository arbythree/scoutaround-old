class UserPreference < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :key, scope: :user
end
