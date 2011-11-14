require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Contact.new.valid?
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

