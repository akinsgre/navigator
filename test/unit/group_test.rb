require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Group.new.valid?
  end
end


# == Schema Information
#
# Table name: groups
#
#  id         :integer         not null, primary key
#  parent_id  :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

