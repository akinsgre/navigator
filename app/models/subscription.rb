class Subscription < ActiveRecord::Base
  belongs_to :user
end


# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer         primary key
#  user_id    :integer
#  created_at :timestamp
#  updated_at :timestamp
#

