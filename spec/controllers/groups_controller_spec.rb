# -*- coding: utf-8 -*-
require 'spec_helper'

describe GroupsController do
  describe "Get 'show' " do
    before :each do
    @user2 = FactoryGirl.create(:user)
    sign_in @user2
      @group1 = FactoryGirl.create(:group, user: @user)
      @group2 = FactoryGirl.create(:group, user: @user2)      
    end
    it "should show the group" do
      get 'show', {:id => @group1.id }
      response.should redirect_to root_path
    end
  end


  describe "GET 'create'" do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
      
    end
    it "should be successful" do
      
      post 'create',{:group => {"name"=>"Test", "description"=>"Test Group", "user_id"=>"1", "sponsor_email"=>"", 
          "bulk_upload"=>""
        }}
      response.should redirect_to Group.last
    end
  end


  describe "GET 'create' with bulk_upload" do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @file = fixture_file_upload('member_list.csv', 'text/csv')
    end
    it "can upload a file" do
      post :create, {
        :group => {"name"=>"Test", 
          "description"=>"Test Group", 
          "user_id"=>"1", 
          "sponsor_email"=>"", 
          "bulk_upload" => @file
        }
      }
      response.should redirect_to Group.last
      
    end
  end
  describe GroupsController do
    before :each do 
      @group = FactoryGirl.create(:group)
      @phone = FactoryGirl.create(:phone)
    end
    describe "GET 'add_contact'" do
      it "should be successful" do
        get 'add_contact', :id => @group.id
        puts response.body
        response.should be_successful
      end
    end
    describe "POST 'save_contact'" do
      it "should save the contact to the group" do
        @group.contacts.length.should eq(1)
        post "save_contact" , "group"=>{"id"=>"1"}, "contact"=>{"type"=>"Phone", "entry"=>"724 454 7790", "identifier"=>"Test"}
        group = assigns[:group]
        group.should_not be_nil
        allContacts = group.contacts.length
        allContacts.should eq(2)
      end
    end
  end
end
