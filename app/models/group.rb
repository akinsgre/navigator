class Group < ActiveRecord::Base
  has_many :contacts, :through => :group_contacts
  has_many :group_contacts

  accepts_nested_attributes_for :contacts
  has_many :contributions

  has_many :sponsors, :through => :group_sponsors
  has_many :group_sponsors
  has_many :messages
  



  belongs_to :user


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
#  id            :integer         not null, primary key
#  parent_id     :integer
#  name          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer
#  description   :string(255)
#  sponsor_email :string(255)
#

