class AddMembershipLevelToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :membership_level_id, :text
  end
end
