class Sponsor < ActiveRecord::Base
  has_many :groups, :through => :group_sponsors
  has_many :group_sponsors
  has_many :contributions
  has_many :advertisements
  
  def self.getPhoneAd
    Advertisement.random_record.phone_message
  end
  def self.getTextAd
    Advertisement.random_record.message
  end
  def self.getEmailAd
    Advertisement.random_record.html_message
  end
end

# == Schema Information
#
# Table name: sponsors
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  phone      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

