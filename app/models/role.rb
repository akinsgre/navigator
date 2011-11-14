class Role < ActiveRecord::Base
  has_many :assignments
  has_many :users, :through => :assignments
  
end


# == Schema Information
#
# Table name: roles
#
#  id         :integer         primary key
#  name       :string(255)
#  created_at :timestamp
#  updated_at :timestamp
#

