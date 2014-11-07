# -*- coding: utf-8 -*-
require 'spec_helper'

describe TwimlController do

  describe "GET 'say'" do
    it "should send error for non xml format" do

      get :say
      expect(response.status).to eq(403)
      
    end
    it "should fail if auth key is not specified" do
      xml = { :format => 'xml' }
      get :say, xml
      expect(response.status).to eq(403)
    end
    it "should succeed if auth key is specified" do
      xml = { :format => 'xml' , :secret => ENV['NMC_API_KEY'] }
      get :say, xml
      expect(response).to be_success
    end
    it "should fail if auth key is specified incorrect" do
      xml = { :format => 'xml' , :secret => 'xxxxxxxxxx' }
      get :say, xml
      expect(response.status).to eq(403)
    end
  end
end
