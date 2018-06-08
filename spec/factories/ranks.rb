FactoryBot.define do
  factory :rank do
    sequence(:name) { |n| "rank #{n}"}
  end
end
