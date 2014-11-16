class AddPhoneMessageToAdvertisements < ActiveRecord::Migration
  def change
    add_column :advertisements, :phone_message, :text
  end
end
