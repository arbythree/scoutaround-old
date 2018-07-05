FactoryBot.define do
  factory :payment_method do
    user_id 1
    last4 "MyString"
    expiration_month 1
    expiration_year 1
    brand "MyString"
    stripe_id "MyString"
  end
end
