class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.integer :sponsor_id
      t.text :message
      t.text :html_message

      t.timestamps
    end
  end
end
