class AdHistory < ActiveRecord::Base
  validates_presence_of :group_id, :sponsor_id, :contact_id
end

# == Schema Information
#
# Table name: ad_histories
#
#  id         :integer         not null, primary key
#  sponsor_id :integer
#  message    :text
#  group_id   :integer
#  contact_id :integer
#  created_at :datetime
#  updated_at :datetime
#

