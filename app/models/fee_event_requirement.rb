class FeeEventRequirement < EventRequirement
  validates :amount_youth, numericality: { greater_than_or_equal_to: 0 }
  validates :amount_adult, numericality: { greater_than_or_equal_to: 0 }
end
