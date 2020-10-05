FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "group#{n}" }
    introduction { "hogehoge" }
    is_closed { "false" }
  end
end
