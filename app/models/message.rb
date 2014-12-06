class Message < ActiveRecord::Base
  belongs_to :group
  belongs_to :contact

  validates_presence_of :message
  validates :message, length: {minimum: 1, maximum: 200 }

end




# == Schema Information
#
# Table name: messages
#
#  id            :integer         not null, primary key
#  message       :string(255)
#  address       :string(255)
#  group_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#  phone_message :text
#  html_message  :text
#

