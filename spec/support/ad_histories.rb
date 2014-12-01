# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ad_history do
    sponsor_id 1
    message "MyText"
    group_id 1
    contact_id 1
  end
end
