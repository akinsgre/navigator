class CreateMembershipLevels < ActiveRecord::Migration
  def change
    create_table :membership_levels do |t|
      t.integer :allowed_messages
      t.text :name

      t.timestamps
    end
  end
end
