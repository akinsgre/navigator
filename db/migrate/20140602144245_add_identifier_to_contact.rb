class AddIdentifierToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :identifier, :string
  end
end
