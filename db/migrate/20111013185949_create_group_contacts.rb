class CreateGroupContacts < ActiveRecord::Migration
  def self.up
    create_table :group_contacts do |t|
      t.integer :group_id
      t.integer :contact_id

      t.timestamps
    end
  end

  def self.down
    drop_table :group_contacts
  end
end
