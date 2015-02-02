require 'spec_helper'

describe Email do
  it "should be created" do
    phone = Email.new
    phone.should_not be_valid
  end
  it "should be created" do
    phone = Email.new
    phone.entry = 'test1@example.com'
    phone.should be_valid
  end
  it "should be created" do
    phone = Email.new
    phone.entry = 'test1+1@example.com'
    phone.should be_valid
  end
  it "should be created" do
    phone = Email.new
    phone.entry = 'test1+1@example0-test.com'
    phone.should be_valid
  end
  it "should not be valid" do
    phone = Email.new
    phone.entry = 'test1.com'
    phone.should_not be_valid
  end
  describe 'deliver' do
    before :each do
      @email = FactoryGirl.create(:email)
      @message = FactoryGirl.create(:message)
      @advertisement = FactoryGirl.create(:advertisement)
    end
    it "should deliver a message" do
      message = mock()

      MessageMailer.expects('send_message').returns(message)
      message.expects(:deliver)
      
      response = @email.deliver(@message, @advertisement)
      response.should eq(@advertisement.html_message)
      
    end
  end
  describe 'verify' do
    before :each do
      @email1 = FactoryGirl.create(:email, entry: 'test1@insomnia-consulting.org')
      @email2 = FactoryGirl.create(:email, entry: 'test1@insomnia-consulting.org')
    end

    it 'an email should cause a verification email to be sent ' do
      message = mock()
      MessageMailer.expects('send_verification').returns(message)
      message.expects(:deliver)
      @email1.request_verification
    end

    it 'should aggregate all like emails' do
      emails = Email.where(entry: @email1.entry)
      puts @email1.entry
      puts @email2.entry
      puts emails.inspect
      expect(emails.size).to eq(2)
      @email1.verify
      emails = Email.where(entry: @email1.entry)
      expect(emails.size).to eq(1)
    end
  end

end






# == Schema Information
#
# Table name: contacts
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  user_id          :integer
#  type             :string(255)
#  entry            :string(255)
#  identifier       :string(255)
#  normalized_entry :text
#  verified         :boolean
#

