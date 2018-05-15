 FactoryBot.define do
  factory :event_submission do
    association :event_registration
    association :event_requirement, factory: :document_event_requirement
    association :submitter, factory: :person
    approved_at { Time.now }
  end
end
