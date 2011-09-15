class Contact < ActiveRecord::Base
  has_many :groups, :class_name => "Group"
  attr_accessible :group_id, :name, :phone
end
