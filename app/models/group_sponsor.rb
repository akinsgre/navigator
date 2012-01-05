class GroupSponsor < ActiveRecord::Base
  belongs_to :group
  belongs_to :sponsor
end

# == Schema Information
#
# Table name: group_sponsors
#
#  id         :integer         not null, primary key
#  group_id   :integer
#  sponsor_id :integer
#  created_at :datetime
#  updated_at :datetime
#

