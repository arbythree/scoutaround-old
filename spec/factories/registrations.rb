FactoryBot.define do
  factory :registration do
    association :event
    association :person
  end
end
