FactoryBot.define do
  factory :membership do
    association :unit
    association :user
  end
end
