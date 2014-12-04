FactoryGirl.define do
  factory :group do
    name 'Test Group'
    description 'test group for the rspec tests'
    after(:create) do |group|
      group.contacts << create(:email)
    end

  end
end


