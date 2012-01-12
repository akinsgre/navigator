class RemoveContactTypes < ActiveRecord::Migration


  def self.up
    drop_table :contact_types
  end
def self.down
    create_table :contact_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
