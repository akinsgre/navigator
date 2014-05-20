class CreateGroupsMembers < ActiveRecord::Migration
  def change

    # Create the association table
    create_table :groups_members, :id => false do |t|
      t.integer :group_id, :null => false
      t.integer :member_id, :null => false
    end

    # Add table index
    add_index :groups_members, [:group_id, :member_id], :unique => true

  end

end
