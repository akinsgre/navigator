class ApplicationController < ActionController::Base
  protect_from_forgery
 before_filter :parse_facebook_cookies

  def parse_facebook_cookies

    @oauth = Koala::Facebook::OAuth.new(ENV['APP_ID'], ENV['SECRET_KEY'])
    Rails.logger.debug "####### Let's see if we can authorize from #{cookies.inspect}"
    test_cookies = @oauth.get_user_info_from_cookies(cookies)
    Rails.logger.debug "###### Did we parse any cookies #{test_cookies}"
    @facebook_cookies ||= @oauth.get_user_info_from_cookies(cookies)
    @fbc = cookies["fbs_#{ENV['APP_ID']}"]
    # if @facebook_cookies then
    #     @graphs = Koala::Facebook::GraphAPI.new(cookies["fbs_"])
    # end

    Rails.logger.debug "####### Got Cookies #{@fbc}"
  end
end
