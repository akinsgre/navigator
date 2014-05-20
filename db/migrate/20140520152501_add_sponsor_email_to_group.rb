class AddSponsorEmailToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :sponsor_email, :string
  end
end
