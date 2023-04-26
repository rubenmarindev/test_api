FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    auth_token { Faker::Alphanumeric.alpha(number: 10) }
  end
end
