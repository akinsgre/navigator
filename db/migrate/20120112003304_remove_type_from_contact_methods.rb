class RemoveTypeFromContactMethods < ActiveRecord::Migration
  def self.up
    remove_column :contacts, :type
  end

  def self.down
    add_column :contacts, :type, :integer
  end
end
