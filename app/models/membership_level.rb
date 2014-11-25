class MembershipLevel < ActiveRecord::Base

  DEFAULT = MembershipLevel.find_by_name( 'Basic')
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
#

