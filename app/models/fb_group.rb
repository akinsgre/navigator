class FbGroup < Contact
  include ActiveModel::Naming
  validates :entry, length: { maximum: 16, minimum: 10 }
  validates :entry, format: { with: /[0-9]/ }

  def self.identify
    "Facebook Group"
  end
  def identify
    "Facebook Group"
  end
  def self.long_description
    "Facebook group id for a group you administer <a class=\"openwindow\" href=\"/help/fb_group\" title=\"How to add a Facebook Group\" ><span class=\"glyphicon glyphicon-info-sign\"></span></a>"
  end

  def self.hide?(user,group)
    Rails.logger.debug "###### User #{user.id unless user.nil?} Group #{group.id unless group.nil?}" 
    user != group.user || !Feature.active?(:facebook, user)

  end
  def deliver(c,message,a,o={})
    if Feature.active?(:facebook, current_user)
      Rails.logger.debug "##### Sending a FB message"
      graph = Koala::Facebook::API.new(current_user.fb_token)
      message_text = "#{message.message}"
      result = graph.put_object("#{c.entry}", "feed", message: message_text)
      return message_text
    end
    retun nil
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
#  verified         :boolean
#

