class Contact < ActiveRecord::Base
  has_many :groups, :through => :group_contacts
  has_many :group_contacts

  belongs_to :user

  validates_presence_of :entry

  require_dependency 'phone'
  require_dependency 'sms'
  require_dependency 'email'
  

  
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


  def self.select_options
    descendants.collect do |d|   [d.identify,d.to_s] end
  end

  def to_s
    "Contact => #{self.name}, #{self.entry}"
  end
end





# == Schema Information
#
# Table name: contacts
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  type       :string(255)
#  entry      :string(255)
#  identifier :string(255)
#

