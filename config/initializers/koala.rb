# config/initializers/koala.rb
# Monkey-patch in Facebook config so Koala knows to 
# automatically use Facebook settings from here if none are given

Koala::Facebook::OAuth.class_eval do
  def initialize_with_default_settings(*args)
    puts "############ #{ENV['APP_ID']}"
    case args.size
      when 0, 1
        raise "application id and/or secret are not specified in the config" unless ENV['APP_ID'] && ENV['SECRET_KEY']
        initialize_without_default_settings(ENV['APP_ID'].to_s, ENV['SECRET_KEY'].to_s, args.first)
      when 2, 3
        initialize_without_default_settings(*args) 
    end
  end 

  alias_method_chain :initialize, :default_settings 
end
