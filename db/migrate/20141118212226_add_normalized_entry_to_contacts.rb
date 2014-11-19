class AddNormalizedEntryToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :normalized_entry, :text
  end
end
