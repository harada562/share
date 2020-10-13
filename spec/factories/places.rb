FactoryBot.define do
  factory :place do
    association :customer
    association :genre
    sequence(:place_name) { |n| "カフェ#{n}" }
    sequence(:address) { |n| "東京都新宿区#{n}" }
    sequence(:number) { |n| "123456789#{n}" }
    sequence(:place_url) { |n| "placeshare.work#{n}" }
    sequence(:budget) { |n| "1000#{n}" }
    sequence(:detail) { |n| "静かなカフェです#{n}" }
  end
end
