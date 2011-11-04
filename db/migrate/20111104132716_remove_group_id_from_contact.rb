class RemoveGroupIdFromContact < ActiveRecord::Migration
  def self.up
    remove_column :contacts, :group_id
  end

  def self.down
    add_column :contacts, :group_id, :integer
  end
end
