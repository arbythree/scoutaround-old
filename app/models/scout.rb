class Scout < Person
  has_many :guardianships, foreign_key: 'guardee_id'
  has_many :guardians, through: :guardianships
end
