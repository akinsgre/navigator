require 'spec_helper'

describe Invite do
  it "should be valid" do
    i = Invite.new({:email => 'test@example.com'})
    i.should be_valid
  end
end
