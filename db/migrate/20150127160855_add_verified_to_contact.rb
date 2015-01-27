class AddVerifiedToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :verified, :boolean
  end
end
