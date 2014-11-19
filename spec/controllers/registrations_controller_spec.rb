# -*- coding: utf-8 -*-
require 'spec_helper'

describe RegistrationsController do
  before :each do
    @user = FactoryGirl.create(:user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  describe "POST 'create'" do
    render_views
    it "should create a registered user" do
      post :create, {:user => { :email => 'notinvited@example.com' }}
      expect(response.status).should eq(200)
      expect(response).to render_template(:new)
    end
  end
end
