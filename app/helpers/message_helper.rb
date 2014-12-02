module MessageHelper
  def record_message(sent_message, group, contact, advertisement)
    AdHistory.create!(message: sent_message, group_id: group.id, contact_id: contact.id, sponsor_id: advertisement.sponsor_id)
    advertisement.sponsor.update_attributes( messages_sent: advertisement.sponsor.messages_sent + 1)
  end
end
