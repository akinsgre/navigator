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
      @sponsor = FactoryGirl.create(:sponsor)
      @ad = FactoryGirl.create(:advertisement)
      @sponsor.advertisements << @ad

    end
    it "can send a message" do

      client = mock()
      account = mock()
      messages = mock()
      sms = mock()

      Twilio::REST::Client.expects('new').returns(client)
      client.expects(:account).times(2).returns(account)
      account.expects(:sms).times(2).returns(sms)
      sms.expects(:messages).times(2).returns(messages)
      messages.expects(:create).times(2).returns("Test Passed")
      post :deliver, {:message => {"message"=> "I've been building enterprise Java web apps since servlets were created.  In that time the java ecosystem has changed a lot but sadly many enterprise Java developers are stuck", :group_id => @group.id}, :group_id => @group.id }

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
      @sponsor = FactoryGirl.create(:sponsor_with_advertisement)
    end
    it "can send a message" do

      client = mock()
      calls = mock()
      account = mock()

      Twilio::REST::Client.expects('new').returns(client)
      client.expects(:account).returns(account)
      account.expects(:calls).returns(calls)
      calls.expects(:create).returns("Phone Test Passed")

      post :deliver, {:message => {"message"=> "This is a message", :group_id => @group.id}, :group_id => @group.id }
      response.should be_success

      expect(assigns(:contacts)).to eq(@group.contacts)
      expect(assigns(:call)).to eq("Phone Test Passed")
    end
  end
end



