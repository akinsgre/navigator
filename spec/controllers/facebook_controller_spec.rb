require 'spec_helper'

describe FacebookController do

  describe "GET 'callback'" do
    it "returns http success" do
      pending 'add some test code'
    end
  end
  describe "GET 'callback'" do
    before :each do
      OmniAuth.config.mock_auth[:facebook] = {
        'uid' => '1337',
        'provider' => 'facebook',
        'info' => {
          'name' => 'angrygreg@gmail.com'
        },
        'credentials' => { 'token' => 'asdfasdfasdf' },
        'grantedScopes' => "test"
      }
      controller.request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    end
    it "returns http success" do
      #.env = {"omniauth.auth" => ""}
      get 'callback', format: :json
      expect(response).to be_success
    end
  end

end
