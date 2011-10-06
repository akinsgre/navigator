class Group < ActiveRecord::Base
  has_many :contacts, :class_name => "Contact"
  has_many :groups, :class_name => "Group"
  belongs_to :user
  attr_accessible :parent_id, :name, :user_id

end

# == Schema Information
#
# Table name: groups
#
#  id            :integer         not null, primary key
#  parent_id     :integer
#  name          :string(255)
#  contact_email :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

