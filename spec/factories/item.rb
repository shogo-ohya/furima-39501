FactoryBot.define do
  factory :item do
    name { "Sample Item" }
    explanation { "This is a sample item." }
    category_id { 2 }
    condition_id { 2 }
    shopping_fee_id { 2 }
    prefecture_id { 2 }
    shopping_duration_id { 2 }
    price { 1000 }
      
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

  end

end
