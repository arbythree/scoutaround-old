FactoryBot.define do
  factory :person do
    first_name 'first'
    last_name  'last'
  end

  factory :youth, class: Youth, parent: :person do
    first_name 'Youth'
    last_name  'Jones'
  end

  factory :adult, class: Adult, parent: :person do
    first_name 'Parent'
    last_name 'Jones'
  end
end
