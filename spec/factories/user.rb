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
