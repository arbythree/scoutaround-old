FactoryBot.define do
  factory :application_datum do
    sequence(:key)   { |n| "key_#{n}" }
    sequence(:value) { |n| "value_#{n}" }
  end
end
