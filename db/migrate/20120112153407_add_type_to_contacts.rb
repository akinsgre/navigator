class AddTypeToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :type, :string
  end

  def self.down
    remove_column :contacts, :type
  end
end
