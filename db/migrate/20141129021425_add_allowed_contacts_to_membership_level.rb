class AddAllowedContactsToMembershipLevel < ActiveRecord::Migration
  def change
    add_column :membership_levels, :allowed_contacts, :integer
  end
end
