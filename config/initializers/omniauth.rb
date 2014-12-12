Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['APP_ID'], ENV['SECRET_KEY'],
  :scope => 'email,user_birthday,read_stream,publish_stream', :display => 'popup', :provider_ignore_state => true

end
