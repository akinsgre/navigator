class CreateGroupContacts < ActiveRecord::Migration
  def self.up
    create_table :group_contacts do |t|
      t.integer :group_id
      t.integer :contact_id

      t.timestamps
    end

    contacts = Contact.all
    contacts.each do |contact| 
      group_contact = GroupContact.create!({:group_id => contact.group_id, :contact_id => contact.id})
    end

  end

  def self.down
    drop_table :group_contacts
  end
end
