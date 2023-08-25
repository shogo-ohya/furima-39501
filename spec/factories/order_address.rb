# spec/factories/order_addresses.rb
FactoryBot.define do
  factory :order_address do
    token { Faker::Alphanumeric.alpha(number: 10) }
    postal_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { Faker::Number.leading_zero_number(digits: 10) }
  end
end