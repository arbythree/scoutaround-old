class Guardianship < ApplicationRecord
  belongs_to :guardee, class_name: 'Person', foreign_key: 'guardee_id'
  belongs_to :guardian, class_name: 'Person', foreign_key: 'guardian_id'
end
