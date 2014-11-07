require 'spec_helper'

describe Message do

  it "should not be created" do
    m = Message.new
    m.should_not be_valid
  end

end






# == Schema Information
#
# Table name: messages
#
#  id         :integer         not null, primary key
#  message    :string(255)
#  address    :string(255)
#  group_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

