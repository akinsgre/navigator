class AddActiveToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :active, :boolean, :default => false
    add_column :sponsors, :messages_sent, :integer, :default => 0
    add_column :sponsors, :messages_allowed, :integer, :default => 0
  end
end
