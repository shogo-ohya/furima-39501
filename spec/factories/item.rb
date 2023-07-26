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
    image_path = Rails.root.join('spec', 'support', 'test_images', 'sample.jpg')
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'test_images', 'sample.jpg'), 'image/jpeg') }
  end

  association :user
end
