class CreateHelps < ActiveRecord::Migration
  def change
    create_table :helps do |t|
      t.text :title
      t.text :info

      t.timestamps
    end
  end
end
