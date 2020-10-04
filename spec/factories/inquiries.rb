FactoryBot.define do
  factory :inquiry do
    title { "testplace" }
   	body { "bodybodybody" }
   	association :customer
  end
end
