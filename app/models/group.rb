class Group < ActiveRecord::Base
  has_many :contacts, :through => :group_contacts
  has_many :group_contacts

  belongs_to :user

  attr_accessible :parent_id, :name, :user_id

#  scope :owned_by, -> (user_id) { where(:user_id =>user_id) }

  def self.search(search)
    if search
      find(:all, :conditions => ['name like ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end


# == Schema Information
#
# Table name: groups
#
#  id         :integer         primary key
#  parent_id  :integer
#  name       :string(255)
#  created_at :timestamp
#  updated_at :timestamp
#  user_id    :integer
#

