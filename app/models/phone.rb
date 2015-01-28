class Phone < Contact
  include ActiveModel::Naming
  phony_normalize :entry, as: :normalized_entry, :default_country_code => 'US'
  validates_plausible_phone :entry, :normalized_country_code => 'US', :message => I18n.t('validations.errors.models.phone.invalid_number')


  def self.identify
    "Phone"
  end
  def identify
    "Phone"
  end
  def self.long_description
    "Phone number (10 digit)"
  end

  def self.normalize_number(number, options = {})
    
    return if number.nil?
    number = number.clone # Just to be sure, we don't want to change the original.
    number.gsub!(/[^\d\+]/, '') # Strips weird stuff from the number

    return if number.blank?
    if default_country_number = options[:default_country_number]

      # Add default_country_number if missing
      number = "#{default_country_number}#{number}" if not number =~ /\A(00|\+|#{default_country_number})/
    end

    Phony.normalize(number)

  rescue => e

    number # If all goes wrong .. we still return the original input.
  end
  def deliver(message, advertisement, options = {})
    client = options[:client]
    group = options[:group]
    
    url = "#{options[:app_url]}/groups/#{group.id}/messages/#{message.id}.xml?contact_id=#{self.id}"
    Rails.logger.debug "####### Calling #{url} ###"
    @call = client.account.calls.create( :from => group.twilio_number, :to => self.entry, :url => url, :method => 'GET', :IfMachine => "Continue" )
    return nil
  rescue  => e
    Rails.logger.error "####### An error occurred #{e.message}"
    Rails.logger.info e.backtrace.join("\n")
  end

  def request_verification
    client = Twilio::REST::Client.new(ENV['TW_SID'],ENV['TW_TOKEN'] )
    
    if Rails.env.development?
      app_url = "http://nmc-demo.herokuapp.com" 
    else
      app_url = "#{request.protocol + request.host_with_port}"
    end
    url = "#{app_url}/contacts/find_for_verification.xml"
    @call = client.account.calls.create( :from => '7242160266', :to => self.entry, :url => url, :method => 'GET' )
    return nil
  rescue  => e
    Rails.logger.error "####### An error occurred #{e.message}"
    Rails.logger.info e.backtrace.join("\n")
  end

  def verification_text
    "You will receive a phone call instructing you to confirm your phone number."
  end
  
end

# == Schema Information
#
# Table name: contacts
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  user_id          :integer
#  type             :string(255)
#  entry            :string(255)
#  identifier       :string(255)
#  normalized_entry :text
#  verified         :boolean
#

