class Sponsor < ActiveRecord::Base
  has_many :groups, :through => :group_sponsors
  has_many :group_sponsors
  has_many :contributions
  has_many :advertisements
  has_many :ad_histories
  scope :active_accounts, -> { 
    Sponsor.where(" active = ? ", true ).reject { |s| !s.messages_allowed.nil? && s.messages_sent >= s.messages_allowed }
  }
  # Long term Advertising algorithm
  # Get a random advertisement from sponsors who have advertisements available
  # and where the zip for the sponsors target demo is in the location of the group/message being delivered.
  # Short Term
  #  Get a randomm advertisement if the sponsors ad count per message doesn't exceed his plan
  def self.getAd
    Advertisement.random_record
  end
  def messages_sent(month_date=Date.today) 
    month_start = Date.new(month_date.year, month_date.month, 1)
    month_end = Date.new(month_date.year, month_date.month, 1).next_month.prev_day
    self.ad_histories.where('created_at >=  ? and created_at <= ?', month_start, month_end).size
  end
end



# == Schema Information
#
# Table name: sponsors
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  email            :string(255)
#  phone            :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  active           :boolean         default(FALSE)
#  messages_allowed :integer         default(0)
#

