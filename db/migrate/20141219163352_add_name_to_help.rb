class AddNameToHelp < ActiveRecord::Migration
  def change
    add_column :helps, :name, :text
  end
end
