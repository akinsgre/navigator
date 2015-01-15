class Group < ActiveRecord::Base
  has_many :contacts, :through => :group_contacts
  has_many :group_contacts
  has_many :fb_group_details, :through => :fb_groups
  has_many :fb_groups
  belongs_to :membership_level

  accepts_nested_attributes_for :contacts
  has_many :contributions

  has_many :sponsors, :through => :group_sponsors
  has_many :group_sponsors
  has_many :messages

  validates_presence_of :membership_level
  validates :name, :presence => true
  validates :name, length: {minimum: 1, maximum: 20}

  validates :twilio_number, :presence => true
  validates_plausible_phone :twilio_number,  :message => I18n.t('validations.errors.models.phone.invalid_number')

  belongs_to :user
  before_save :runthis
  after_initialize :associate_defaults

  def self.search(search)
    if search
      where('name like ?', "%#{search}%")
    else
      find(:all)
    end
  end
  
  def exceed_contacts?
    !membership_level.allowed_contacts.nil? && (contact_count >= membership_level.allowed_contacts)
  end
  def exceed_messages?
    Rails.logger.debug "##### Messages exceeded?  Group ID: #{id}, MembershipLevel: #{self.membership_level.inspect}"
    !membership_level.allowed_messages.nil? && (monthly_message_count >= membership_level.allowed_messages)
  end
  def contact_count
    self.contacts.size
  end
  def monthly_message_count(month_date=Date.today)
    month_start = Date.new(month_date.year, month_date.month, 1)
    month_end = Date.new(month_date.year, month_date.month, 1).next_month.prev_day
    self.messages.where('created_at >=  ? and created_at <= ?', month_start, month_end).size
  end
  private

  def associate_defaults
    ml = MembershipLevel.DEFAULT

    #self.update_attribute :membership_level_id, ml.id
    self.membership_level ||= ml
    self.twilio_number ||= ENV['TW_NUMBER']
  end
  private 
  def runthis
    Rails.logger.debug "############# We're updating self"
    caller.each { |line| Rails.logger.debug line }
  end
end



# == Schema Information
#
# Table name: groups
#
#  id                  :integer         not null, primary key
#  parent_id           :integer
#  name                :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  user_id             :integer
#  description         :string(255)
#  sponsor_email       :string(255)
#  membership_level_id :integer
#  twilio_number       :text
#

