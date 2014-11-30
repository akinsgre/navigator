class AddNameIndexToMembershipLevel < ActiveRecord::Migration
  def change
    add_index :membership_levels, :name, unique: true
  end
end
