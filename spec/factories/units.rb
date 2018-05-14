FactoryBot.define do
  factory :unit do
    number 1
    location 'location'
  end

  factory :troop, parent: :unit do
    type 'Troop'
  end
end
