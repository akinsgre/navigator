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
#  id         :integer         primary key
#  parent_id  :integer
#  name       :string(255)
#  created_at :timestamp
#  updated_at :timestamp
#  user_id    :integer
#

