# FactoryBot.define do
#   factory :user do
#     nickname              {Faker::Internet.username}
#     first_name            {Faker::Name.name }
#     last_name             {Faker::Name.name}
#     first_kana_name       {Faker::Name.name.tr('ぁ-ん', 'ァ-ン')}
#     last_kana_name        {Faker::Name.name.tr('ぁ-ん', 'ァ-ン')}
#     email                 {Faker::Internet.unique.email}
#     password              {Faker::Internet.password(min_length: 6)}
#     password_confirmation {password}
#     birth_day             {Faker::Date.between(from: '1900-01-01', to: '2024-12-31')}
#   end
# end

FactoryBot.define do
  factory :user do
    nickname              { Faker::Internet.username }
    first_name            { '山田' }
    last_name             { '太郎' }
    first_kana_name       { 'ヤマダ' }
    last_kana_name        { 'タロウ' }
    email                 { Faker::Internet.unique.email }
    birth_day             { Date.new(1990, 1, 1) } 
    password              { 'abc123' }
    password_confirmation { password }
  end
end
