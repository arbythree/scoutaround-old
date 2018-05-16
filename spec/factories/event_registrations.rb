FactoryBot.define do
  factory :event_registration do
    association :event
    association :user, factory: :youth
  end
end
