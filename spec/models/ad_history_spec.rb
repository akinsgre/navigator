require 'spec_helper'

describe AdHistory do
  let(:group) { FactoryGirl.create(:group) }
  let(:sponsor) { FactoryGirl.create(:sponsor) }
  let(:email) { FactoryGirl.create(:email) }
  let(:advertisement) { FactoryGirl.create(:advertisement)}
  let(:mail) { MessageMailer.send_message(email, message, advertisement) }
  
  it "should be invalid without all associations" do
    ah = AdHistory.new
    expect(ah).to_not be_valid
  end
  it "should be valid if all assocations are set" do
    ah = AdHistory.new(:group_id => group.id, :contact_id => email.id, :sponsor_id => sponsor.id)
    expect(ah).to be_valid
  end
end
