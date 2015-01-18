# -*- coding: utf-8 -*-
require 'spec_helper'

describe TwimlController do

  describe "GET 'say'" do
    render_views
    before :each do
      @group = FactoryGirl.create(:group)
    end
    it "should fail if auth key is not specified" do
      get :say
      expect(response.status).to eq(403)
    end

    it "should succeed if auth key is specified" do
      xml = { :secret => ENV['NMC_API_KEY'], :message => 'This is a test', 
        :group => @group.name, :sponsor_msg => "Brought to you by ..."  }
      get :say, xml
      Rails.logger.info "##### Response: #{response.body}"
      expect(response).to be_success
    end

    it "should fail if auth key is specified incorrect" do
      xml = { :format => 'xml' , :secret => 'xxxxxxxxxx' }
      get :say, xml
      expect(response.status).to eq(403)
    end
  end
end
