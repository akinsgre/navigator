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

