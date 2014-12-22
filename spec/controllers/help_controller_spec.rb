require 'spec_helper'

describe HelpController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    before :each do
      @help = FactoryGirl.create(:help)
    end
    it "returns http success" do
      get 'show', id: @help.name
      response.should be_success
    end
  end

end
