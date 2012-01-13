class RemovePhoneFromContact < ActiveRecord::Migration
  def self.up
    remove_column :contacts, :phone
  end

  def self.down
    add_column :contacts, :phone, :string
  end
end
