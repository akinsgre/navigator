require 'awesome_print'
class FacebookController < ApplicationController
  respond_to :html, :json
  
  def callback
    Rails.logger.debug "########################################"
    auth = request.env['omniauth.auth']
    #extend_fb_token(auth['credentials']['token'])
    Rails.logger.debug "##### Scopes : #{auth['grantedScopes']}"
    if current_user
      current_user.fb_token = auth['credentials']['token'] 
      if current_user.save
        respond_with("success")
      else
        respond_with("failure")
      end
    end
  end
  def index
    @access_token = current_user.fb_token
    Rails.logger.debug "##### Access Token = #{@access_token}"
    graph = Koala::Facebook::API.new(@access_token)
    graph.put_object('10203899060529169', "feed", :message => "This is just a test of an app I'm writing.#{Date.today.to_s}")
    profile_path = graph.get_picture("10203899060529169",:type=>"large")
    Rails.logger.debug "###### Profile path #{profile_path}"    
    
  end
  def extend_fb_token(token)
    # can be called once a day to extend fb access token
    # if called twice or more in one day, will return the same token
    require "net/https"
    require "uri"
    url = "https://graph.facebook.com/oauth/access_token?client_id=#{ENV['APP_ID']}&client_secret=#{ENV['SECRET_KEY']}&grant_type=fb_exchange_token&fb_exchange_token=#{token}"
    Rails.logger.debug "##### Posting #{url}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    Rails.logger.debug "##### Got his response #{response.body}"
    matched_response = /access_token=(.+)&expires=(.+)/.match(response.body)
    parsed_response = Hash["extension", Hash["token", matched_response[1], "expiry", matched_response[2]]]
    return parsed_response
  end
end
