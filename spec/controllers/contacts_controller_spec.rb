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
    describe "GET 'new'" do
      it "should return 404 with invalid Group ID" do
        get :new, :user => true, :group_id => 999
        expect(response.status).to eq(404)
        expect(assigns(:contact)).to be_nil
      end
    end
    describe "GET 'index'" do
      it "should be successful" do
        get :index, :group_id => @group
        expect(response).to redirect_to root_path
      end
    end
    describe "GET 'search'" do

      it "should be successful" do
        get :search, :entry => '724 454 7790', :format => 'json'
        expect(response).to be_success
        expect(assigns(:contacts)).to_not be_empty

      end
    end
    describe "POST 'create'" do
      before :each do
        @c = FactoryGirl.create(:phone)
        @group = FactoryGirl.create(:group)
        @group.contacts << @c 
        @group.save
      end
      it "should be updated if the contact exists" do
        params = ActionController::Parameters.new(
                                                  { "contact"=>{"user_id"=>"", 
                                                      "group"=>{"id"=>@group.id}, 
                                                      "name"=>"Ralphie", 
                                                      "type"=>"Phone", 
                                                      "entry"=>"724 454 7790"}, 
                                                    "group_id"=>@group.id})
        expect{ post :create, params }.to change(Contact,:count).by(0)
 
      end
      it "should be not add to Group if already exists on group" do
        Rails.logger.info "START ##################################"
        Rails.logger.info "#######################################"
        Contact.find(@c.id).groups.size.should eq(1)
        params = ActionController::Parameters.new(
                                                  { "contact"=>{"user_id"=>"", 
                                                      "group"=>{"id"=>@group.id}, 
                                                      "name"=>"Ralphie", 
                                                      "type"=>"Phone", 
                                                      "entry"=>"724 454 7790"}, 
                                                    "group_id"=>@group.id})
        expect{ post :create, params }.to change(Contact,:count).by(0)
        Rails.logger.info "#######################################"
        Rails.logger.info "END #################################"
        Contact.find(@c.id).groups.size.should eq(1)

      end
    end
    describe "POST 'assign'" do
      before :each do
        @contact = FactoryGirl.create(:phone)
      end
      it "should be successful" do
        
        post :assign, {"name"=>"contactsubmit", "value"=>['3'], "pk"=>"1", "controller"=>"contacts", "action"=>"assign"}
        expect(response).to be_success

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
