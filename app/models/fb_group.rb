class FbGroup < Contact
  include ActiveModel::Naming
#  validates :entry, :email => { :message => I18n.t('validations.errors.models.email.invalid_email')}

  def self.identify
    "Facebook Group"
  end
  def identify
    "Facebook Group"
  end
  def self.long_description
    "Facebook group that you administrate"
  end
  def self.hide?
    true
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

