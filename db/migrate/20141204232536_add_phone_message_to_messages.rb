class AddPhoneMessageToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :phone_message, :text
  end
end
