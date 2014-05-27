require 'spec_helper'

describe Contribution do
  it "should be created" do
    c = Contribution.new
    c.should be_valid
  end
end

# == Schema Information
#
# Table name: contributions
#
#  id         :integer         not null, primary key
#  group_id   :integer
#  sponsor_id :integer
#  amount     :decimal(10, 2)
#  created_at :datetime
#  updated_at :datetime
#

