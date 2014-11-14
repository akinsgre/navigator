require 'spec_helper'

describe Advertisement do
  it "should not be valid" do
    a = Advertisement.new
    a.should_not be_valid
  end
  it "should not valid" do
    a = Advertisement.new
    a.sponsor  = FactoryGirl.create(:sponsor)
    a.message = "Test"
    a.html_message = "<b>Test</b>"
    a.should be_valid
  end
end

# == Schema Information
#
# Table name: advertisements
#
#  id           :integer         not null, primary key
#  sponsor_id   :integer
#  message      :text
#  html_message :text
#  created_at   :datetime
#  updated_at   :datetime
#

