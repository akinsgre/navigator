require 'spec_helper'

describe Email do
  it "should be created" do
    phone = Email.new
    phone.should_not be_valid
  end
  it "should be created" do
    phone = Email.new
    phone.entry = 'test1@example.com'
    phone.should be_valid
  end
  it "should be created" do
    phone = Email.new
    phone.entry = 'test1+1@example.com'
    phone.should be_valid
  end
  it "should be created" do
    phone = Email.new
    phone.entry = 'test1+1@example0-test.com'
    phone.should be_valid
  end
  it "should not be valid" do
    phone = Email.new
    phone.entry = 'test1.com'
    phone.should_not be_valid
  end

end




# == Schema Information
#
# Table name: contacts
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  type       :string(255)
#  entry      :string(255)
#  identifier :string(255)
#

