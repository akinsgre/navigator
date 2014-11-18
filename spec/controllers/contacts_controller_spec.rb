# -*- coding: utf-8 -*-
require 'spec_helper'

describe ContactsController do

  describe "GET 'index'" do
    before :each do
      @user = FactoryGirl.create(:user)
      @user.role << FactoryGirl.create(:role)
      sign_in @user
      @group = FactoryGirl.create(:group)

    end
    it "should be successful" do
      get :index, :group_id => @group
      expect(response.status).to eq(200)
    end
  end
  before :each do
    @email = FactoryGirl.create(:email)
  end
  describe "GET 'opt_out'" do
    it "should be successful" do
      get :opt_out, contact_id:  @email
      expect(response.status).to eq(200)
    end
  end
end
