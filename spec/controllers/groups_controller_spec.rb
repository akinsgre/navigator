# -*- coding: utf-8 -*-
require 'spec_helper'

describe GroupsController do
  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  describe "GET 'create'" do
    it "should be successful" do
      ##<ActionDispatch::Http::UploadedFile:0x00000103ea9148 @tempfile=#<Tempfile:/var/folders/5c/v_l0d9zd6bbbjmvcvjlh8sgh0000gn/T/RackMultipart20140526-7087-1padjo>, @original_filename="member_list.csv", @content_type="text/csv", @headers="Content-Disposition: form-data; name=\"group[bulk_upload]\"; filename=\"member_list.csv\"\r\nContent-Type: text/csv\r\n">
      post 'create',{:group => {"name"=>"Test", "description"=>"Test Group", "user_id"=>"1", "sponsor_email"=>"", 
        "bulk_upload"=>""
        }}
      response.should redirect_to Group.last
    end
  end

  describe "GET 'create' with bulk_upload" do
    before :each do
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

end
