FactoryBot.define do
  factory :unit do
    sequence(:number) { |n| "#{n}" }
    sequence(:city)   { |n| "city_#{n}"}
    sequence(:state)  { |n| "state_#{n}"}
    association :subscription_plan
  end

  factory :troop, parent: :unit do
    type 'Troop'
  end
end
