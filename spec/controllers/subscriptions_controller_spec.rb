require 'spec_helper'

describe SubscriptionsController do

  describe "GET 'new'" do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit', :id => 1
      response.should be_success
    end
  end

  describe "GET 'show'" do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    it "should be successful" do
      get 'show', :id => 1
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "should be successful" do
      get 'destroy', :id => 1
      response.should be_success
    end
  end

end
