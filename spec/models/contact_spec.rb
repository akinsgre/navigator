require 'spec_helper'

describe Contact do
  it "should not be created" do
    c = Contact.new
    c.should_not be_valid
  end
  it "should be created" do
    c = Contact.new
    c.entry = 'test'
    c.identifier = "G. AKins' home phone"
    c.should be_valid
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

