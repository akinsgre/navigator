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

      @group.save
      Rails.logger.info "######### Spec Group.contacts are #{@group.contacts.inspect}"
      @sponsor = FactoryGirl.create(:sponsor)
      @ad = FactoryGirl.create(:advertisement)
      @sponsor.advertisements << @ad

    end
    it "can send a message" do
      DeliverWorker.expects('perform_async').at_least(1)

      post :deliver, {:message => {"message"=> "I've been building enterprise Java web apps since servlets were created.  In that time the java ecosystem has changed a lot but sadly many enterprise Java developers are stuck", :group_id => @group.id}, "messages"=>{"0"=>"Test Group One: The Text message is required. This will be used for text messages and email. If the Phone message isn't specified, then the text message will be", "1"=>" used for Text, Phone and Email.--Insomnia-Consulting.org: Software development services."}, :group_id => @group.id }

      response.should be_success
      
      expect(assigns(:contacts)).to eq(@group.contacts)
      Rails.logger.info "twilioMessage"
      Rails.logger.info "########################## FINISH"      
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

      DeliverWorker.expects('perform_async').at_least(1)

      post :deliver, {:message => {"message"=> "This is a message", :group_id => @group.id}, :group_id => @group.id }
      response.should be_success

      expect(assigns(:contacts)).to eq(@group.contacts)
#      expect(assigns(:call)).to eq("Phone Test Passed")
    end
  end
  describe 'show' do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @group = FactoryGirl.create(:group)
      contacts = FactoryGirl.create_list(:email, 2)
      @phone = FactoryGirl.create(:phone)
      contacts << @phone
      @group.contacts << contacts
      @sponsor = FactoryGirl.create(:sponsor_with_advertisement)
      @message = FactoryGirl.create(:message)
    end
    it 'should respond to show with say.xml' do
       get 'show', group_id: @group.id, id: @message.id, contact_id: @phone.id
      response.should be_success

    end
  end
end



