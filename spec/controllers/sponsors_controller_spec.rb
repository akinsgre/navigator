require 'spec_helper'

describe SponsorsController do

  describe "GET 'info'" do
    before :each do
      @user2 = FactoryGirl.create(:user)
      sign_in @user2
    end
    it "should fail because of non-admin user" do
      get :index
      expect(response).to redirect_to new_admin_session_path
    end
    it "should fail because of non-admin user" do
      get :new
      expect(response).to redirect_to new_admin_session_path
    end
  end
  describe "GET 'index'" do
    before :each do
      @user2 = FactoryGirl.create(:admin)
      sign_in @user2
    end
    it "should be successful" do
      get :index
      expect(response).to be_success
    end
    it "should be successful" do
      get :new
      expect(response).to be_success
      expect(assigns(:sponsor)).to_not be_nil
    end
  end

end
