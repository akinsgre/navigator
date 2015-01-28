require 'spec_helper'

describe Phone do
  describe 'valid phone numbers' do
    it "should be created" do
      phone = Phone.new
      phone.should_not be_valid
    end
    it "should be created" do
      phone = Phone.new
      phone.entry = '17245551212'
      phone.should be_valid
      phone.should be_valid
      phone.normalized_entry.should eq(PhonyRails.normalize_number(phone.entry, :default_country_code => 'US'))
    end
    it "should be created (format 1)" do
      phone = Phone.new
      phone.entry = '1724 555 1212'

      phone.should be_valid
      phone.normalized_entry.should eq(PhonyRails.normalize_number(phone.entry, :default_country_code => 'US'))
    end
    it "should be created (format 2)" do
      phone = Phone.new
      phone.entry = '(724) 555 - 1212'

      phone.should be_valid
      phone.normalized_entry.should eq(PhonyRails.normalize_number(phone.entry, :default_country_code => 'US'))
    end
    it "should be created (format 3)" do
      phone = Phone.new
      phone.entry = '724.555.1212'

      phone.should be_valid
      phone.normalized_entry.should eq(PhonyRails.normalize_number(phone.entry, :default_country_code => 'US'))
    end
  end
  describe 'invalid phone numbers' do
    it "should be created (format 3)" do
      phone = Phone.new
      phone.entry = '724.555.1'

      phone.should_not be_valid

    end
  end
  describe 'verify' do
    before :each do
      @phone = FactoryGirl.create(:phone)
    end

    it 'an email should cause a verification email to be sent ' do
      # message = mock()
      # MessageMailer.expects('send_verification').returns(message)
      # message.expects(:deliver)
      @phone.request_verification
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

