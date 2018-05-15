FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "event_#{n}" }
    association :unit
    starts_at { 6.weeks.from_now }
    ends_at   { 7.weeks.from_now }
    sequence(:location) { |n| "event_location_#{n}" }
  end
end
