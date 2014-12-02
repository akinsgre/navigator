class Sponsor < ActiveRecord::Base
  has_many :groups, :through => :group_sponsors
  has_many :group_sponsors
  has_many :contributions
  has_many :advertisements
  scope :active_accounts, -> { 
    Sponsor.where(" active = ? and (messages_sent < messages_allowed or messages_allowed is null)", true )
  }
  # Long term Advertising algorithm
  # Get a random advertisement from sponsors who have advertisements available
  # and where the zip for the sponsors target demo is in the location of the group/message being delivered.
  # Short Term
  #  Get a randomm advertisement if the sponsors ad count per message doesn't exceed his plan
  def self.getAd
    Advertisement.random_record
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

