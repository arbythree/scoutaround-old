FactoryBot.define do
  factory :unit do
    number 1
    sequence(:location) { |n| "location_#{n}" }
  end

  factory :troop, parent: :unit do
    type 'Troop'
  end
end
