require 'spec_helper'

describe Assignment do
  it "should be valid" do
    a = Assignment.new
    a.should be_valid
  end
end



# == Schema Information
#
# Table name: assignments
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  role_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

