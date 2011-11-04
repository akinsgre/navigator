class AddContactTypeIdToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :contact_type_id, :integer
  end

  def self.down
    remove_column :contacts, :contact_type_id
  end
end
