FactoryBot.define do
  factory :admin do
    nick_name { "test" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testest" }
  end
end
