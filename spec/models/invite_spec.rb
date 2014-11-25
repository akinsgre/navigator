require 'spec_helper'

describe Invite do
  it "should be valid" do
    i = Invite.new({:email => 'test@example.com'})
    i.should be_valid
  end
end

# == Schema Information
#
# Table name: invites
#
#  id         :integer         not null, primary key
#  email      :text
#  created_at :datetime
#  updated_at :datetime
#

