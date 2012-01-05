class Contact < ActiveRecord::Base
  has_many :groups, :through => :group_contacts
  has_many :group_contacts
  belongs_to :contact_type

  belongs_to :user
  attr_accessible :name, :phone, :user_id, :contact_type_id
  
  #GAK 11/4/2011 
  #  Email is a virtual attribute so it can be captured in a form_for but then assigned to the User to whom the contact belongs
  #  rather than being saved on the Contact record (which breaks for those contacts created by group_owners and not associated 
  #  with a user account.. Got to think about this some.

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
#  id              :integer         not null, primary key
#  name            :string(255)
#  phone           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  user_id         :integer
#  contact_type_id :integer
#

