require 'spec_helper'

describe Message do

  it "should not be valid without message" do
    m = Message.new
    m.should_not be_valid
  end
  it "should not be valid with too long message" do
    m = Message.new
    m.message = "This is a message that is too long.  It has more than 200 characters asfdghkj asdfghjk asdfghjk asdfghkj asdfghjk asdfghjk asdfghkj asdfghjk asdfhjkl asdfhjkl asdfhjkl asdfhjkl asdfhjlkasdf hjklasdfh xxx"
    m.should_not be_valid
  end
  it "should be created" do
    m = Message.new
    m.message = "This is a test"
    m.phone_message = "This is a test"
    m.html_message = "<p>This is a a test</p>"
    m.should be_valid
  end

end







# == Schema Information
#
# Table name: messages
#
#  id            :integer         not null, primary key
#  message       :string(255)
#  address       :string(255)
#  group_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#  phone_message :text
#  html_message  :text
#

