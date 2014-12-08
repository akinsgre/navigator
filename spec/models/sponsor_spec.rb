require 'spec_helper'
describe 'Sponsor with limited messages' do
  before :each do
    @sponsor = FactoryGirl.create(:sponsor_with_advertisement, messages_allowed: 1)

  end
  it "should create a sponsor" do
    puts @sponsor.inspect
    ad = FactoryGirl.create(:ad_history, :sponsor_id => 2)
    puts ad.inspect
    expect( Sponsor.active_accounts.size).to eq(1)

  end
end
describe Sponsor do
  before :each do
    @sponsor = FactoryGirl.create(:sponsor_with_advertisement)
  end
  it "should create a sponsor" do
    s = Sponsor.new
    s.should_not be_nil
  end
  it "should have a static method to get a random advertisement" do
    Sponsor.where(" active = ? ", true ).reject { |s| !s.messages_allowed.nil? && s.messages_sent >= s.messages_allowed }
    ad = Sponsor.getAd
    ad.phone_message.should match('Notify My Club dot org.  Help your club get the word out')
    ad.message.should match('MyText')
    ad.html_message.should match('<b>MyHtml</b>')
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
#  id               :integer         not null, primary key
#  name             :string(255)
#  email            :string(255)
#  phone            :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  active           :boolean         default(FALSE)
#  messages_sent    :integer         default(0)
#  messages_allowed :integer         default(0)
#

