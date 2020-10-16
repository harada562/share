FactoryBot.define do
  factory :admin do
    sequence(:nick_name) { |n| "管理者#{n}" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testest" }
  end
end
