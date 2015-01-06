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
      patch 'update', :id => advertisement, :sponsor_id => sponsor, :advertisement => { 
        :message => 'test', 
        :html_message => 'html message', 
        :phone_message => 'test' }
      response.should be_redirect
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
    before :each do
      @advertisement = FactoryGirl.create(:advertisement)
      @sponsor = FactoryGirl.create(:sponsor)
    end
    it "returns http success" do
      get 'edit', :id => @advertisement, :sponsor_id => @sponsor 
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do
    before :each do
      @advertisement = FactoryGirl.create(:advertisement)
      @sponsor = FactoryGirl.create(:sponsor)
    end
    it "returns http success" do
      expect { delete :destroy, :id => @advertisement, :sponsor_id => @sponsor }.to change(Advertisement, :count)
      response.should be_redirect
      request.flash[:notice].should eq('Successfully deleted Advertisement.')

    end
  end

  describe "DELETE 'destroy'" do
    before :each do
      @advertisement = FactoryGirl.create(:advertisement)
      @sponsor = FactoryGirl.create(:sponsor)
    end
    it "fails to delete" do
      advertisement = stub()

      advertisement.stubs(:destroy){ raise "this error" }
      advertisement.stubs(:id).returns(12)
      Advertisement.stubs(:find).with('12').returns(advertisement)

      expect { delete :destroy, :id => advertisement.id, :sponsor_id => @sponsor.id }.to_not change(Advertisement, :count)
      response.should be_redirect
      request.flash[:alert].should eq('Unable to delete Advertisement.')

    end
  end


end
