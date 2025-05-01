FactoryBot.define do
  factory :order do
    association :user
    association :item
    
    trait :with_address do
      after(:create) do |order|
        create(:address, order: order)
      end
    end
  end
end
