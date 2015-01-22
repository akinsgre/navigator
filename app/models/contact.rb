class Contact < ActiveRecord::Base
  has_many :groups, :through => :group_contacts
  has_many :group_contacts

  has_many :messages

  belongs_to :user

  validates_presence_of :entry

  require_dependency 'phone'
  require_dependency 'sms'
  require_dependency 'email'
  require_dependency 'fb_group'

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
  def self.hide?(user,group)
    false
  end
  def self.select_options(user, group)
    Rails.logger.debug "##### User owns group (#{user.id} == #{group.user.id}) #{user == group.user}" unless user.nil?
    descendants.reject { |d| d.hide?(user, group ) }.collect { |d| [d.identify,d.to_s] }
  end

  def to_s
    "Contact => #{self.name}, #{self.entry}"
  end

  def self.determine_type(params)
    contact = nil
    contactType = params[:contact][:type]
    normalized_entry = Phone.normalize_number(params[:contact][:entry], :default_country_number => '01')

    contactExists = Contact.exists?(params[:id]) || 
      ( !normalized_entry.nil? && Contact.exists?(:normalized_entry => normalized_entry, :type => contactType) ) || 
      Contact.exists?(:entry => params[:contact][:entry], :type => contactType)
    if contactExists
      Rails.logger.info "###### Contact Exists"
      ActiveRecord::Base.transaction do
        contact = Contact.find(params[:id]) unless params[:id].nil?
        Rails.logger.info "###### Contact found by ID is #{contact.inspect}"
        contact ||= Contact.find_by(:normalized_entry => normalized_entry, :type => contactType) unless normalized_entry.nil?
        Rails.logger.info "###### Contact found by normalized_entry is #{contact.inspect}"
        contact ||= Contact.find_by(:entry => params[:contact][:entry], :type => contactType) unless params[:contact][:entry].empty?
        Rails.logger.info "###### Contact found by entry is #{contact.inspect}"
        Rails.logger.info "###### Contact is #{contact.inspect}"
        if contact.type != contactType 
          contact.type = contactType 
          contact.save
        end
        Rails.logger.info "###### After setting contact type Contact is #{contact.inspect}"
        case contactType
        when 'Phone'
          contact = contact.becomes(Phone)
        when 'Sms'
          contact = contact.becomes(Sms)
        when 'Email'
          contact = contact.becomes(Email)
        when 'FbGroup'
          contact = contact.becomes(FbGroup)
        else
          raise "Not a supported type"
        end
        Rails.logger.info "###### After become Contact is #{contact.inspect}"
        contact = Contact.find(contact.id)
        unless contact.update_attributes(params[:contact].permit(:name, :user_id, :entry))
          Rails.logger.error "##### Had to rollback transaction because #{contact.errors.full_messages}"
          raise ActiveRecord::Rollback 
        end
        Rails.logger.info "###### Completed contact modification #{contact.inspect}"
      end
    else
      puts "##### The contact does not exist"
      case  contactType 
      when'Phone'
        contact = Phone.new(params[:contact].permit(:name, :user_id, :entry, :type))
      when 'Sms'
        contact = Sms.new(params[:contact].permit(:name, :user_id, :entry, :type))
      when 'Email'
        contact = Email.new(params[:contact].permit(:name, :user_id, :entry, :type))
      when 'FbGroup'
        contact = FbGroup.new(params[:contact].permit(:name, :user_id, :entry, :type))
      else
        raise "Not a supported type"
      end
      contact.save
    end
    Rails.logger.info "##### Returning contact #{contact.inspect}"
    return contact
  end

end

# == Schema Information
#
# Table name: contacts
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  user_id          :integer
#  type             :string(255)
#  entry            :string(255)
#  identifier       :string(255)
#  normalized_entry :text
#

