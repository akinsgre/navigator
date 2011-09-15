class Group < ActiveRecord::Base
  has_many :contacts, :class_name => "Contact"
  attr_accessible :parent_id, :name, :contact_email

end
