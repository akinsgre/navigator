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
#

