class User < ActiveRecord::Base
  has_many :subscription
  has_many :assignments
  has_many :role, :through => :assignments
  has_many :contacts
  has_many :groups
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  #strong_parameters :email, :password, :password_confirmation, :remember_me

  def admin?
    isAdmin = false ; 
    self.role.each { |r|
      if r.name == 'Administrator'
        isAdmin = true
      end
      
    }
    return isAdmin
  end

  def following
    groupIds = Array.new
    #find group_contacts.group_id where contact_id = contact.id
    self.contacts.each do |c|
      groupIds += c.groups
    end
    return groupIds
  end

  def subscribed?
    return !self.subscription.blank?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super
    end
  end
end



# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

