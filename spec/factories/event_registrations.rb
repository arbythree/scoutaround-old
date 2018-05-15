FactoryBot.define do
  factory :event_registration do
    association :event
    association :person, factory: :youth
  end
end
