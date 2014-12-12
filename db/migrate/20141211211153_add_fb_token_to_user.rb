class AddFbTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :fb_token, :text
  end
end
