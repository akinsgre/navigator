FactoryGirl.define do
  factory :email  do
    name "Test User"
    sequence :entry do |n|
      "person#{n}@example.com"
    end
  end
end
