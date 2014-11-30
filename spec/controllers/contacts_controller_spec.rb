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
    describe "GET 'new'" do
      it "should be successful with user specified" do
        get :new, :user => true, :group_id => @group.id
        expect(response.status).to eq(200)
        expect(assigns(:contact)).to_not be_nil
        expect(assigns(:contact).user_id).to eq(@user.id)
      end
    end
    describe "GET 'index'" do
      it "should be successful" do
        get :index, :group_id => @group
        expect(response).to redirect_to root_path
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
  describe "Not Logged In" do
    before :each do
      @email = FactoryGirl.create(:email)
      @group = FactoryGirl.create(:group)
    end
    describe "GET 'new'" do
      it "should be successful with no ID" do
        get :new, :group_id => @group.id
        expect(response.status).to eq(200)
        expect(assigns(:contact)).to_not be_nil
        expect(assigns(:contact).user_id).to be_nil
      end
      it "should redirect_to group if there are more contacts than allowed" do
        get :new, :group_id => @group.id
        expect(response.status).to eq(200)
        expect(assigns(:contact)).to_not be_nil
        expect(assigns(:contact).user_id).to be_nil
      end
      it "should be successful with user specified" do
        get :new, :user => true, :group_id => @group.id
        expect(response.status).to eq(200)
        expect(assigns(:contact)).to_not be_nil
        expect(assigns(:contact).user_id).to be_nil
      end
    end
    describe "GET 'opt_out'" do
      it "should be successful" do
        get :opt_out, contact_id:  @email
        expect(response.status).to eq(200)
      end

    end
  end
end
