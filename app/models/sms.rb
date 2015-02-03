class Sms < Contact
  include ActiveModel::Naming
  phony_normalize :entry, as: :normalized_entry, :default_country_code => 'US'
  validates_plausible_phone :entry, :normalized_country_code => 'US', :message => I18n.t('validations.errors.models.sms.invalid_number')

  def self.identify
    "Text Message"
  end
  def identify
    "Text Message"
  end

  def self.long_description
    "Phone number (that receives text messages)"
  end
  def build_message(message, advertisement)
    message_text = message.message
    template = "#{message.group.name}: \r\n\r\n#{advertisement.message}\r\n\r\nReply \"STOP#{message.group.id}\" to cancel"
    msg = []
    allowable_msg_length = 160 - template.length
    chunks = (message_text.length/allowable_msg_length)+1
    messageCount = 0
    chunks.times  do |b| 
      short_message = message_text[b*(allowable_msg_length),allowable_msg_length]
      body = "#{message.group.name}: #{short_message}\r\n\r\n#{advertisement.message}\r\n\r\nReply \"STOP#{message.group.id}\" to cancel"
      msg << body

    end
    return msg
  end
  def deliver(message, advertisement, options = {})
    client = options[:client]
    group = options[:group]
    message_text = ''
    build_message(message, advertisement).each do |msg|
      @twilioMessage = client.account.sms.messages.create({
                                                            :from => group.twilio_number, 
                                                            :to => self.entry, 
                                                            :body => msg
                                                          })
    end
    return advertisement.message
  rescue => e
    Rails.logger.error "###### An error occurred in Sms.deliver #{e.message}"
    Rails.logger.debug e.backtrace.join("\n")
  end
  def request_verification
    client = Twilio::REST::Client.new(ENV['TW_SID'],ENV['TW_TOKEN'] )
    @twilioMessage = client.account.sms.messages.create({
                                                            :from => '7242160266',
                                                            :to => self.entry, 
                                                            :body => "NotifyMyClub would like to verify that you own this phone number.  Reply \"VERIFY#{self.id}\" to confirm."
                                                          })
    return nil
  rescue  => e
    Rails.logger.error "####### An error occurred #{e.message}"
    Rails.logger.debug e.backtrace.join("\n")
  end

  def verification_text
    "You will receive a text message instructing you to confirm your phone number."
  end
  def verify
    Rails.logger.info "####### Model is #{self.inspect}"
    Sms.delete_all(["normalized_entry = ? and id <> ?", self.normalized_entry, self.id])
    self.verified = true
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

