class RemoveMessagesSentFromSponsor < ActiveRecord::Migration
  def change
    remove_column :sponsors, :messages_sent
  end
end
