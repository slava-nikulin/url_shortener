FactoryBot.define do
  factory :url_pair do
    original_url { Faker::Internet.url }
    short_path { UrlPair.new.send(:generate_short_path) }
    clicks_count { Faker::Number.number(3) }
  end
end
