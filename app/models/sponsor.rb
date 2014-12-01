class Sponsor < ActiveRecord::Base
  has_many :groups, :through => :group_sponsors
  has_many :group_sponsors
  has_many :contributions
  has_many :advertisements
  
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

