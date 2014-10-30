FactoryGirl.define do
  factory :group do
    name 'test'
    description 'test group'
    after(:create) do |group|
      group.contacts << create(:email)

    end
  end
end
