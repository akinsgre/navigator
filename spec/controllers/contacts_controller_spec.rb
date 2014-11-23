# -*- coding: utf-8 -*-
require 'spec_helper'

describe ContactsController do

  describe "Logged In" do
    before :each do
      @user = FactoryGirl.create(:user)
      @user.role << FactoryGirl.create(:role)
      sign_in @user
      @group = FactoryGirl.create(:group)
      @contact = FactoryGirl.create(:phone)
    end
    describe "GET 'index'" do
      it "should be successful" do
        get :index, :group_id => @group
        expect(response.status).to eq(200)
      end
    end
    describe "PATCH 'update'" do
      it "should be successful" do
        patch :update, { "contact"=>{"user_id"=>"", "group"=>{"id"=>@group.id}, "name"=>"Test One", "type"=>"Email", "entry"=>"testone@insomnia-consulting.org"}, "group_id"=>@group.id, "id"=>@contact.id} 
        assigns(:contact).entry.should eq("testone@insomnia-consulting.org")
        expect(response).to redirect_to(group_contact_path(@group, @contact))
      end
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
