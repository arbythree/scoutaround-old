class Guardianship < ApplicationRecord
  belongs_to :guardee,  class_name: 'User', foreign_key: 'guardee_id'
  belongs_to :guardian, class_name: 'User', foreign_key: 'guardian_id'
  validates_uniqueness_of :guardee, scope: :guardian
end
