FactoryBot.define do
  factory :unit do
    sequence(:number) { |n| "#{n}" }
    sequence(:location) { |n| "location_#{n}" }
  end

  factory :troop, parent: :unit do
    type 'Troop'
  end
end
