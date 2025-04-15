FactoryBot.define do
  factory :item do
    association :user
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.between(from: 300, to: 9_999_999)}
    genre_id { 2 }
    product_condition_id { 2 }
    free_shopping_id { 2 }
    prefecture_id { 2 }
    delivery_day_id { 2 }

    after(:build) do |message|
      message.image.attach(io: File.open('spec/fixtures/files/test_image.png'), filename: 'test_image.png')
    end
  end
end
