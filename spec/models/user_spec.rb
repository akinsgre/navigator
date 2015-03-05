require 'spec_helper'

describe User do
  before :each do

  end
  it "should fix groups" do
    user = FactoryGirl.create(:user)
    group = FactoryGirl.create(:group, :user => user)
    group.user = user
    user.fix_groups
    group = Group.find(group.id)
    expect(group.user_id).to be_nil
    expect(group.users.count).to eq(1)
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
#  membership_level_id :integer
#  twilio_number       :text
#

