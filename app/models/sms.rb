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
    Rails.logger.info "######## OK.. let's call SMS deliver"
    client = options[:client]
    group = options[:group]
    Rails.logger.info "##### Sending Twilio... 160 character message limit so long message is split into several message"
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
    Rails.logger.info e.backtrace.join("\n")
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

