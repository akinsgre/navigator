# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :advertisement do
    sponsor_id "1"
    message "MyText"
    html_message "<b>MyHtml</b>"
    phone_message 'Notify My Club dot org.  Help your club get the word out/'
  end
end
