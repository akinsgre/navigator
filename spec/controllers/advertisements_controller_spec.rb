require 'spec_helper'

describe AdvertisementsController do

  describe "GET 'new'" do
    let(:sponsor) { FactoryGirl.create(:sponsor) }
    it "returns http success" do
      get 'new', :sponsor_id => sponsor 
      response.should be_success
      expect(assigns(:advertisement)).to_not be_nil
    end
  end

  describe "GET 'index'" do
    let(:sponsor) { FactoryGirl.create(:sponsor) }
    it "returns http success" do
      get 'index', :sponsor_id => sponsor 
      response.should be_success
    end
  end

  describe "GET 'create'" do
    let(:sponsor) { FactoryGirl.create(:sponsor) }
    it "returns http success" do
      get 'create', :sponsor_id => sponsor, :advertisement => {:message => 'This is a test', :html_message => '<p>My Message</p>', :phone_message => 'Read this via voice'} 
      response.should redirect_to(sponsors_path)
      expect(assigns(:advertisement)).to_not be_nil
      expect(assigns(:advertisement).message).to eq('This is a test')
      expect(assigns(:advertisement).sponsor).to eq(sponsor)

    end
  end

  describe "PATCH 'update'" do
    let(:advertisement) { FactoryGirl.create(:advertisement) }
    let(:sponsor) { FactoryGirl.create(:sponsor) }
    it "returns http success" do
      patch 'update', :id => advertisement, :sponsor_id => sponsor 
      response.should be_success
    end
  end

  describe "GET 'show'" do
    let(:advertisement) { FactoryGirl.create(:advertisement) }
    let(:sponsor) { FactoryGirl.create(:sponsor) }
    it "returns http success" do
      get 'show', :id => advertisement, :sponsor_id => sponsor 
      response.should be_success
    end
  end

  describe "GET 'edit'" do

    let(:advertisement) { FactoryGirl.create(:advertisement) }
    let(:sponsor) { FactoryGirl.create(:sponsor) }
    it "returns http success" do
      get 'edit', :id => advertisement, :sponsor_id => sponsor 
      response.should be_success
    end
  end

end
