require 'spec_helper'

describe Sms do
  it "should be created" do
    phone = Sms.new
    phone.should_not be_valid
  end
  it "should be created" do
    phone = Sms.new
    phone.entry = '17245551212'
    phone.should be_valid
  end
  it "should be created" do
    phone = Sms.new
    phone.entry = '1724 555 1212'
    phone.should be_valid
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
#

