class CreateGroupSponsors < ActiveRecord::Migration
  def self.up
    create_table :group_sponsors do |t|
      t.integer :group_id
      t.integer :sponsor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :group_sponsors
  end
end
