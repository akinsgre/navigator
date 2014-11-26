# -*- coding: utf-8 -*-
require 'spec_helper'

describe UsersController do

  describe "Not Logged In" do
    before :each do
      @user = FactoryGirl.create(:user)
    end
    describe "GET 'show'" do
      it "should be successful" do
        get :show, :id => @user.id
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
