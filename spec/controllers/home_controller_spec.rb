# -*- coding: utf-8 -*-
require 'spec_helper'

describe HomeController do
  render_views
  describe "GET 'index'" do
    it "should be successful" do
      get :index
      expect(response).to be_success
      expect(response.body).to contain("Best of all, the application is free to your members.")
    end
  end
end
