FactoryGirl.define do
  factory :contact  do
    name "Test User"
    sequence :entry do |n|
      "person#{n}@example.com"
    end
  end
end
