FactoryBot.define do
  factory :membership do
    association :unit
    association :person
  end
end
