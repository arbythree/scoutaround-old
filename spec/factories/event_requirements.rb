FactoryBot.define do
  factory :event_requirement do
    association :event
  end

  factory :document_event_requirement, class: DocumentEventRequirement, parent: :event_requirement do
  end

  factory :payment_event_requirement, class: PaymentEventRequirement, parent: :event_requirement do
  end
end
