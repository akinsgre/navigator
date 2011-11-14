class Message < ActiveRecord::Base
  belongs_to :groups
end


# == Schema Information
#
# Table name: messages
#
#  id         :integer         primary key
#  message    :string(255)
#  address    :string(255)
#  group_id   :integer
#  created_at :timestamp
#  updated_at :timestamp
#

