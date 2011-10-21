class Group < ActiveRecord::Base
  has_many :group_contacts
  has_many :contacts, :through => :group_contacts

  belongs_to :user

  attr_accessible :parent_id, :name, :user_id

  scope :owned_by, ->(user_id) {where(:user_id =>user_id)}

end


# == Schema Information
#
# Table name: groups
#
#  id         :integer         not null, primary key
#  parent_id  :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

