class Contact < ActiveRecord::Base
  has_many :groups, :through => :group_contacts
  has_many :group_contacts
  has_many :messages

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
  def self.determine_type(params)

    contactType = params[:contact][:type]
    if Contact.exists?(params[:id])
      ActiveRecord::Base.transaction do
        @contact = Contact.find(params[:id]).becomes(Contact)
        if @contact.type != contactType 
          @contact.type = contactType 
          @contact.save
        end
        case contactType
        when 'Phone'
          @contact = @contact.becomes(Phone)
        when 'Sms'
          @contact = @contact.becomes(Sms)
        when 'Email'
          @contact = @contact.becomes(Email)
        else
          raise "Not a supported type"
        end

        @contact = Contact.find(@contact.id)
        raise ActiveRecord::Rollback unless @contact.update_attributes(params[:contact].permit(:name, :user_id, :entry))
      end
    else
      case  contactType 
      when'Phone'
        @contact = Phone.new(params[:contact].permit(:name, :user_id, :entry, :type))
      when 'Sms'
        @contact = Sms.new(params[:contact].permit(:name, :user_id, :entry, :type))
      when 'Email'
        @contact = Email.new(params[:contact].permit(:name, :user_id, :entry, :type))
      else
        raise "Not a supported type"
      end
      @contact.save
    end
    @contact
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

