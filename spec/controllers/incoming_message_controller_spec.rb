require 'spec_helper'

describe IncomingMessageController do

  describe "POST 'receive'" do
    before :each do
      @sms = FactoryGirl.create(:sms)
      @phone = FactoryGirl.create(:phone)
      @group = FactoryGirl.create(:group)
      @group.contacts << @sms
      @group.save
    end
    it "returns http 403" do
      get :receive
      response.status.should eq(403)
      
    end

    it "returns http not found" do
      data = {  :secret => ENV['NMC_API_KEY'], "From" => '+17244547790' }
      get :receive, data
      response.status.should eq(404)
    end
    it "returns http success destroying Sms" do
      data = {  :secret => ENV['NMC_API_KEY'], "From" => '+17244547790', "SmsSid" => "asdfasdf", "Body" => "STOP#{@group.id}" }
      get :receive, data
      response.status.should eq(200)
      c = Contact.exists?(@sms.id)
      expect(c).to be_true
      GroupContact.find_by_contact_id_and_group_id(@sms.id, @group.id).should be_nil
    end
    it "returns http success destroying phone" do
      data = {  :secret => ENV['NMC_API_KEY'], "From" => '+17244547790', "CallSid" => "asdfasdf" }
      get :receive, data

      response.status.should eq(200)
      c = Contact.exists?(@phone.id)
      c.should be_false
    end
  end

end
