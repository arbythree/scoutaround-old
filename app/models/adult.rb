class Adult < User
  has_many :guardianships, foreign_key: 'guardian_id'
  has_many :guardees, through: :guardianships
end
