require 'spec_helper'

describe GroupSponsor do
  it 'should allow sponsors to be added to group' do
  group = Group.new
  sponsor = Sponsor.new
  group.sponsors << sponsor
  group.save

  group.sponsors.should have(1).items
  end
end

# == Schema Information
#
# Table name: group_sponsors
#
#  id         :integer         not null, primary key
#  group_id   :integer
#  sponsor_id :integer
#  created_at :datetime
#  updated_at :datetime
#

