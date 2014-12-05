class AddHtmlMessageToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :html_message, :text
  end
end
