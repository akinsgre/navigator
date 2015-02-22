require 'spec_helper'

describe Sms do
  it "should be created" do
    phone = Sms.new
    phone.should_not be_valid
  end
  it "should be created" do
    phone = Sms.new
    phone.entry = '17245551212'
    phone.should be_valid
  end
  it "should be created" do
    phone = Sms.new
    phone.entry = '1724 555 1212'
    phone.should be_valid
  end
  it "should create a new Sms depending on type" do
    params = ActionController::Parameters.new(contact: { entry:'27244547790', type:'Sms', name: 'Test One' } )
    contact = Contact.determine_type(params)
    contact.should_not be_nil
  end
  it "should update a Contact depending on type" do
    sms = Sms.new
    sms.entry = '1724 555 1212'
    sms.save
    params = ActionController::Parameters.new(contact: { entry:'7244547790', type:'Phone', name: 'Test One', id: sms.id  } )
    contact = Contact.determine_type(params)
    contact = Contact.find(contact.id)
    contact.should_not be_nil
    contact.type.should eq('Phone')
  end
  it "should update a Contact depending on type" do
    sms = Sms.new
    sms.entry = '1724 555 1212'
    sms.save
    params = ActionController::Parameters.new(contact: { entry:'7244547790', type:'Phone', name: 'Test One', id: sms.id  } )
    contact = Contact.determine_type(params)
    contact = Contact.find(contact.id)

    contact.should_not be_nil
    contact.type.should eq('Phone')
    contact.entry.should eq('7244547790')
  end
  describe 'verify' do
    before :each do
      @sms1 = FactoryGirl.create(:sms)
      @sms2 = FactoryGirl.create(:sms)
    end

    it 'should cause a verification text to be sent ' do
      client = mock()
      account = mock()
      sms = mock()
      messages = mock()

      Twilio::REST::Client.expects('new').returns(client)
      client.expects(:account).returns(account)
      account.expects(:sms).returns(sms)
      sms.expects(:messages).returns(messages)
      messages.expects(:create)
      @sms1.request_verification
    end

    it 'should aggregate all like text numbers' do
      phone_nums = Sms.where(entry: @sms1.entry)
      expect(phone_nums.size).to eq(2)
      @sms1.verify
      phone_nums = Sms.where(entry: @sms1.entry)
      expect(phone_nums.size).to eq(1)
    end
  end
  it "should split message into multiple messages" do
    Rails.logger.info "######################### SDFSDSDFFSFD"
    sms = Sms.new
    message = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam pellentesque luctus auctor. Sed eu dignissim ipsum. Donec suscipit in libero ut pretium. Aenean posuere libero in mi sagittis aliquam. Nulla commodo, lorem vel euismod tincidunt, enim lectus dictum tellus, non elementum lectus massa id quam. Integer volutpat laoreet felis. Maecenas ut commodo tellus. Vivamus eget libero neque. Vivamus molestie tellus rhoncus magna varius, vitae mattis ipsum vulputate. Vivamus tempus mi ac arcu faucibus vulputate ac aliquam sapien."
    messages = sms.split(message)
    expect(messages.size).to eq(4)
    expect(messages[0]).to eq("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam pellentesque luctus auctor. Sed eu dignissim ipsum. Donec suscipit in libero ut pretium. Aenean ")
    expect(messages[0] + messages[1] + messages[2] + messages[3]).to eq(message)
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

