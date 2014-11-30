class AddMembershipLevelToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :membership_level_id, :integer
  end
end
