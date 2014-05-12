class AddEntryToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :entry, :string
  end

  def self.down
    remove_column :contacts, :entry
  end
end
