FactoryGirl.define do
  factory :sponsor do
    sequence(:name) {|n| "sponsor#{n}" }
    sequence(:email) {|n| "sponsor#{n}@example.com" }
    messages_allowed nil
    active true
    factory :sponsor_with_advertisement do
      after(:create) do |sponsor|
        create(:advertisement, sponsor: sponsor)
      end
  end
  end
end
