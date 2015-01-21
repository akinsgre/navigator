require 'spec_helper'

describe Contact do
  before :each do
    @group = FactoryGirl.create(:group)
    @contact = FactoryGirl.create(:phone)
  end
  it "should not be created" do
    c = Contact.new
    c.should_not be_valid
  end
  it "should be created" do
    c = Contact.new
    c.entry = 'test'
    c.identifier = "G. AKins' home phone"
    c.should be_valid
  end

  it "should determine type" do
    params = ActionController::Parameters.new( :contact=>{:user_id=>"", :group=>{:id=>@group.id}, :name=>"Test One", :type=>@contact.type, :entry=>@contact.entry}, :group_id=>@group.id, :id=>@contact.id )
    c = Contact.determine_type( params )
    c.should_not be_nil
    c.should eq(@contact)
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

