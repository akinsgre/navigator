require 'spec_helper'

describe Role do
  it "should be valid" do
    r = Role.new
    r.should be_valid
  end
end



# == Schema Information
#
# Table name: roles
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

