require 'spec_helper'

describe Sponsor do
  it "should create a sponsor" do
    s = Sponsor.new
    s.should_not be_nil
  end
end

# == Schema Information
#
# Table name: sponsors
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  phone      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

