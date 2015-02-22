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

  def split(message)

    messages = []
    i = 0
    while ( !message.nil? && message.length > 1) do
      splitposition = 159
      while message[splitposition] != ' ' && splitposition < message.length do
        splitposition -= 1 
      end
      Rails.logger.info "%%%%% next message = #{message[splitposition + 1..message.length-1]} "
      messages[i] = message[0..splitposition]
      Rails.logger.info "##### saved messages[#{i}] = #{messages[i]} "
      message = message[splitposition +1,message.length+1] unless message.nil?
      Rails.logger.info "##### Remaining message = #{message} "
      i += 1
    end
    return messages
  end

  def deliver(message_id, advertisement, options = {})
    client = Twilio::REST::Client.new(ENV['TW_SID'], ENV['TW_TOKEN'])
    group = Group.find(options[:group_id])
    message = Message.find(message_id)

    message_text = "#{group.name} : #{message.message} -- #{advertisement.message} -- Respond with STOP#{group.id} to stop notifications."
    messages = split(message_text)
    Rails.logger.debug "##### Messages are #{messages.inspect}"
    messages.each do |msg|
      Rails.logger.debug "##### Message is #{msg}"
      @twilioMessage = client.account.sms.messages.create({
                                                            :from => group.twilio_number, 
                                                            :to => self.entry, 
                                                            :body => msg
                                                          })
    end
    return messages.to_a.join('\n')
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

