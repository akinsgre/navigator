class Email < Contact
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
end

# == Schema Information
#
# Table name: contacts
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  type       :string(255)
#  entry      :string(255)
#  identifier :string(255)
#

