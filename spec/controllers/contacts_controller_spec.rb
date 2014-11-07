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
      expect(response).to eq(:success)
    end
  end

end
