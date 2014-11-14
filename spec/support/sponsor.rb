FactoryGirl.define do
  factory :sponsor do
    sequence(:name) {|n| "sponsor#{n}" }
    sequence(:email) {|n| "sponsor#{n}@example.com" }

  end
end
