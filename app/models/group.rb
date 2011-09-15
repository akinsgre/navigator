class Group < ActiveRecord::Base
  attr_accessible :parent_id, :name, :contact_email
end
