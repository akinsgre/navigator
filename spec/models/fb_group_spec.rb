require 'spec_helper'

describe FbGroup do
  it "should be created" do
    fbGroup = Email.new
    fbGroup.should_not be_valid
  end
  it "should be created" do
    fbGroup = FbGroup.new
    fbGroup.entry = '761662830593159'
    fbGroup.should be_valid
  end
  it "should be created" do
    fbGroup = FbGroup.new
    fbGroup.entry = '610870339039421'
    fbGroup.should be_valid
  end

end






# == Schema Information
#
# Table name: contacts
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  user_id          :integer
#  type             :string(255)
#  entry            :string(255)
#  identifier       :string(255)
#  normalized_entry :text
#  verified         :boolean
#

