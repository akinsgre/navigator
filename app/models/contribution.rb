class Contribution < ActiveRecord::Base
  belongs_to :group
  belongs_to :sponsor
end

# == Schema Information
#
# Table name: contributions
#
#  id         :integer         not null, primary key
#  group_id   :integer
#  sponsor_id :integer
#  amount     :decimal(10, 2)
#  created_at :datetime
#  updated_at :datetime
#

