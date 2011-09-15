class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.integer :parent_id
      t.string :name
      t.string :contact_email
      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
