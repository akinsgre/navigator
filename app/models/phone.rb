class Phone < Contact

  validates_length_of :entry, :is => 10, :message => 'must be 10 digits, excluding special characters such as spaces and dashes. No extension or country code allowed.', :if => Proc.new{|o| !o.entry.blank?}

  def self.identify
    "Phone"
  end
def self.long_description
  "Phone number (10 digit)"
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

