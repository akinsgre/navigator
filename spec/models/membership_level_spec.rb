require 'spec_helper'

describe MembershipLevel do

  it "can't be created with duplicate name" do
    expect(MembershipLevel.DEFAULT.name).to eq('Basic')

    m = MembershipLevel.new
    m.name = 'Basic'
    expect { m.save }.to raise_error(ActiveRecord::RecordNotUnique)

  end
end





# == Schema Information
#
# Table name: membership_levels
#
#  id               :integer         not null, primary key
#  allowed_messages :integer
#  name             :text
#  created_at       :datetime
#  updated_at       :datetime
#  allowed_contacts :integer
#

