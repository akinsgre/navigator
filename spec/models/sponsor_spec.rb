require 'spec_helper'

describe Sponsor do
  before :each do
    @ad = FactoryGirl.create(:advertisement)
  end
  it "should create a sponsor" do
    s = Sponsor.new
    s.should_not be_nil
  end
  it "should have a static appendAdd method" do
    message = 'test'
    message = Sponsor.getAd
    message.should match('MyText')
  end

  it "should have advertisements" do
    s = Sponsor.new
    s.advertisements.size.should eq(0)
    s.advertisements << FactoryGirl.create(:advertisement)
    s.advertisements.size.should eq(1)
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

