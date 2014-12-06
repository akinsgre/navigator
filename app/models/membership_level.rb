class MembershipLevel < ActiveRecord::Base
  
  def self.DEFAULT 
    MembershipLevel.find_by_name( 'Basic')
  end
end



# == Schema Information
#
# Table name: membership_levels
#
#  id               :integer         not null, primary key
#  allowed_messages :integer
#  name             :text
#  created_at       :datetime
#  updated_at       :datetime
#  allowed_contacts :integer
#

