# spec/factories/address_orders.rb
FactoryBot.define do
  factory :address_order do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    house_number { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { '09012345678' }
    user_id { nil }
    item_id { nil }
  end
end
