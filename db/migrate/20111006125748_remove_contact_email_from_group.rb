class RemoveContactEmailFromGroup < ActiveRecord::Migration
  def self.up
    remove_column :groups, :contact_email
  end

  def self.down
    add_column :groups, :contact_email, :string
  end
end
