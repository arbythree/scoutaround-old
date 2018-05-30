class Achievable < ApplicationRecord
  has_many :requirements, class_name: 'Achievable', foreign_key: 'parent_achievable_id', dependent: :destroy
end
