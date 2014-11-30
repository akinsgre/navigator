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
      @group1 = FactoryGirl.create(:group, user: @user)
      puts "##### Membership level is #{@group1.membership_level}" 
      sign_in @user
    end
    it "should be redirect to created group" do
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
    describe "GET 'index'. not logged in" do
      it 'should return 404' do
        get :index, :format => :html
        expect(response.status).to eq(200)
      end
    end
    describe "GET 'add_contact'" do
      it "should be successful" do
        get 'add_contact', :id => @group.id
        puts response.body
        response.should be_successful
      end
    end

  end
end
