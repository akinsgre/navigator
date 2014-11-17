FactoryGirl.define do
  factory :email  do
    name "Test User"
    sequence :entry do |n|
      "angrygreg+#{n}@gmail.com"
    end
  end
end
