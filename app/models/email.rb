class Email < Contact
  include ActiveModel::Naming
  validates :entry, :email => { :message => I18n.t('validations.errors.models.email.invalid_email')}

  def self.identify
    "Email"
  end
  def identify
    "Email"
  end
  def self.long_description
    "Valid email address"
  end
  def deliver(contact, message, advertisement, options = {})
    MessageMailer.send_message(contact,message, advertisement).deliver
    sent_message = advertisement.html_message
  rescue => e
    Rails.logger.error "####### There was a problem #{e.message} "
    raise e
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
#

