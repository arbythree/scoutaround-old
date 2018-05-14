FactoryBot.define do
  factory :guardianship do
    association :guardee, factory: :youth
    association :guardian, factory: :adult
  end
end
