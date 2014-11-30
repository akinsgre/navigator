require 'spec_helper'

describe Group do
  before :each do

  end
  it "should have a default membership level of 'Basic'" do
    group = Group.new(name: 'test')
    expect(group.membership_level.name).to eq(MembershipLevel.find_by_name('Basic').name)
    group.should be_valid
  end
  it "should not allow a nil number" do
    group = Group.new(name: 'test')
    group.twilio_number = nil
    expect(group).to_not be_valid
  end

  it "should not be valid without a name" do
    group = Group.new
    expect(group).to_not be_valid
  end

  it 'should allow send messages' do
    group = Group.new(name: 'test')
    expect(group.exceed_messages?).to be_false
  end
  it 'should refuse to allow send messages when group membership is basic' do
    group = Group.new(name: 'test')
    (1..9).each do
      message = FactoryGirl.create(:message)
      group.messages << message
    end
    group.save
    expect(group.exceed_messages?).to be_false
  end
  it 'should refuse to allow additional contacts when group membership is basic' do
    group = Group.new(name: 'test')
    (1..9).each do
      email = FactoryGirl.create(:email)
      group.contacts << email
    end
    group.save
    expect(group.exceed_contacts?).to be_false
  end
  it 'should refuse to add contacts when membership is basic' do
    group = Group.new(name: 'test')
    (1..11).each do
      email = FactoryGirl.create(:email)
      group.contacts << email
    end
    group.save
    expect(group.exceed_contacts?).to be_true
  end
  it 'should refuse to send messages when membership is basic' do
    group = Group.new(name: 'test')
    (1..10).each do
      message = FactoryGirl.create(:message)
      group.messages << message
    end
    group.save
    expect(group.exceed_messages?).to be_false
  end

  it 'should never refuse to send messages when group membership is premium' do
    group = Group.new(name: 'test', membership_level: MembershipLevel.find_by_name('Premium'))
    (1..30).each do
      message = FactoryGirl.create(:message)
      group.messages << message
    end
    group.save
    expect(group.exceed_messages?).to be_false
  end
  it 'should never refuse to add contacts when group membership is premium' do
    group = Group.new(name: 'test', membership_level: MembershipLevel.find_by_name('Premium'))
    (1..30).each do
      message = FactoryGirl.create(:message)
      group.messages << message
    end
    group.save
    expect(group.exceed_contacts?).to be_false
  end
end

#
# Table name: groups
#
#  id            :integer         not null, primary key
#  parent_id     :integer
#  name          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer
#  description   :string(255)
#  sponsor_email :string(255)
#




# == Schema Information
#
# Table name: groups
#
#  id                  :integer         not null, primary key
#  parent_id           :integer
#  name                :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  user_id             :integer
#  description         :string(255)
#  sponsor_email       :string(255)
#  membership_level_id :text
#  twilio_number       :text
#

