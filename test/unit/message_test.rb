require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: messages
#
#  id         :integer         not null, primary key
#  message    :string(255)
#  address    :string(255)
#  group_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
