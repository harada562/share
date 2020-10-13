FactoryBot.define do
  factory :inquiry do
    sequence(:title) { |n| "お問い合わせタイトル#{n}" }
    sequence(:body) { |n| "お問い合わせ内容#{n}" }
    association :customer
  end
end
