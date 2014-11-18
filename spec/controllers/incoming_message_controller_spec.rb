require 'spec_helper'

describe IncomingMessageController do

  describe "POST 'receive'" do
    it "returns http 4003" do
      get 'receive'
      response.should_not eq(403)
    end
    it "returns http success" do
      data = {  :secret => ENV['NMC_API_KEY'] }
      get :receive, data

      expect(response).to be_success
      response.should be_success
    end
  end

end
