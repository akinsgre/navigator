class Contact < ActiveRecord::Base
  has_many :groups, :class_name => "Group"
  belongs_to :user
  attr_accessible :group_id, :name, :phone, :user_id, :email
  
  def email
    @email  
  end
  def email=(email)
    @email = email
  end

end


# == Schema Information
#
# Table name: contacts
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  phone      :string(255)
#  group_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

