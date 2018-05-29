class Requirement < ApplicationRecord
  belongs_to :achievable
  belongs_to :required, class_name: 'Achievement'
end
