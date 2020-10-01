FactoryBot.define do
  factory :customer do
    nick_name { "customer" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
  end
end
