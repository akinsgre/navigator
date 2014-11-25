require 'spec_helper'

describe GroupContact do
  it "should allow a contact to be added to a group" do
    g = Group.new
    c = FactoryGirl.create(:email)
    g.contacts << c
    g.save
    g.contacts.should have(1).items
  end
end

# == Schema Information
#
# Table name: group_contacts
#
#  id         :integer         not null, primary key
#  group_id   :integer
#  contact_id :integer
#  created_at :datetime
#  updated_at :datetime
#

