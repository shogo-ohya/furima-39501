FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :room

    after(:build) do |item|
      message.image.attach(io: File.open('spec/support/test_images/sample.jpg'), filename: 'sample.jpg', content_type: 'image/jpg')
    end
    
  end
end