class Sms < Contact
  validates_plausible_phone :entry, :normalized_country_code => 'US', :message => I18n.t('validations.errors.models.sms.invalid_number')

  def self.identify
    "Text Message"
  end
  def self.long_description
    "Phone number (that receives text messages)"
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

