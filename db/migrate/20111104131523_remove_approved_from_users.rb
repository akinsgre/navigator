class RemoveApprovedFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :approved
  end

  def self.down
    add_column :users, :approved, :boolean
  end
end
