require 'spec_helper'

describe Phone do
  it "should be created" do
    phone = Phone.new
    phone.should_not be_valid
  end
  it "should be created" do
    phone = Phone.new
    phone.entry = '17245551212'
    phone.should be_valid
  end
  it "should be created" do
    phone = Phone.new
    phone.entry = '1724 555 1212'

    phone.should be_valid
    phone.normalized_entry.should eq(Phony.normalize(phone.entry))
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

