FactoryBot.define do
  factory :customer do
  	# sequenceは末尾の数字を増やしていく処理
    sequence(:nick_name) { |n| "customer#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
  end
end
