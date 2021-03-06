class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name
      t.string :phone
      t.integer :group_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
