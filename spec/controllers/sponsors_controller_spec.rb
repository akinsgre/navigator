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
  end

end
