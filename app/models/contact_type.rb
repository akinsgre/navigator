class ContactType < ActiveRecord::Base
  has_one :contact
end

# == Schema Information
#
# Table name: contact_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

