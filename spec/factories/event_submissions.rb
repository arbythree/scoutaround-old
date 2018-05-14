FactoryBot.define do
  factory :event_submission do
    association :registration
    association :event_requirement
    association :submitter, factory: :person
  end
end
