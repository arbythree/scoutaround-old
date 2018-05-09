class Adult < Person
  has_many :guardianships, foreign_key: 'guardian_id'
  has_many :guardees, through: :guardianships
end
