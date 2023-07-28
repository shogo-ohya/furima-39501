FactoryBot.define do
  factory :item do
    name { "Sample Item" }
    explanation { "This is a sample item." }
    category_id { 1 }
    condition_id { 1 }
    shopping_fee_id { 1 }
    prefecture_id { 1 }
    shopping_duration_id { 1 }
    price { 1000 }
      
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

  end

end
