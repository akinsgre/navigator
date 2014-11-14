require 'spec_helper'

describe MessagesController do

  describe 'SMS' do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @group = FactoryGirl.create(:group)
      contacts = FactoryGirl.create_list(:email, 2)
      contacts << FactoryGirl.create(:sms)
      @group.contacts << contacts

      @ad = FactoryGirl.create(:advertisement)

    end
    it "can send a message" do

      client = mock()
      account = mock()
      messages = mock()
      sms = mock()

      Twilio::REST::Client.expects('new').returns(client)
      client.expects(:account).returns(account)
      account.expects(:sms).returns(sms)
      sms.expects(:messages).returns(messages)
      messages.expects(:create).returns("Test Passed")

      post :deliver, {:message => {"message"=> "This is a test", "group_id" => @group.id }}
      response.should be_success

      expect(assigns(:contacts)).to eq(@group.contacts)
      expect(assigns(:twilioMessage)).to eq("Test Passed")
    end
  end
  describe 'Phone' do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @group = FactoryGirl.create(:group)
      contacts = FactoryGirl.create_list(:email, 2)
      contacts << FactoryGirl.create(:phone)
      @group.contacts << contacts
      @ad = FactoryGirl.create(:advertisement)
    end
    it "can send a message" do

      client = mock()
      calls = mock()
      account = mock()

      Twilio::REST::Client.expects('new').returns(client)
      client.expects(:account).returns(account)
      account.expects(:calls).returns(calls)
      calls.expects(:create).returns("Phone Test Passed")

      post :deliver, {:message => {"message"=> "This is a test", "group_id" => @group.id }}
      response.should be_success

      expect(assigns(:contacts)).to eq(@group.contacts)
      expect(assigns(:call)).to eq("Phone Test Passed")
    end
  end
end



