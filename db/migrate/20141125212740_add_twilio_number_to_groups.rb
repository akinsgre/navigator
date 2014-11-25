class AddTwilioNumberToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :twilio_number, :text
  end
end
