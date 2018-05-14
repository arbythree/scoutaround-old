FactoryBot.define do
  factory :event do
    name 'event_name'
    association :unit
  end
end
