class CreateAdHistories < ActiveRecord::Migration
  def change
    create_table :ad_histories do |t|
      t.integer :sponsor_id
      t.text :message
      t.integer :group_id
      t.integer :contact_id

      t.timestamps
    end
  end
end
