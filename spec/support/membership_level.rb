# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :membership_level do
    allowed_messages 1
    name "MyText"
  end
end

