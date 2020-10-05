FactoryBot.define do
  factory :place do
    place_name { "testplace" }
    address { "東京都" }
    association :customer
  end
end
