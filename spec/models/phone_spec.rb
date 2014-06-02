require 'spec_helper'

describe Phone do
  it "should be created" do
    phone = Phone.new
    phone.should_not be_valid
  end
  it "should be created" do
    phone = Phone.new
    phone.entry = '7245551212'
    phone.should be_valid
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
#

