class GroupContact < ActiveRecord::Base
  belongs_to :contact
  belongs_to :group
end

# == Schema Information
#
# Table name: group_contacts
#
#  id         :integer         not null, primary key
#  group_id   :integer
#  contact_id :integer
#  created_at :datetime
#  updated_at :datetime
#

