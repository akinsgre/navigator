module MessageHelper
  def record_message(sent_message, group_id, contact, advertisement)
    Rails.logger.debug("###### sent_message #{sent_message}")
    Rails.logger.debug("###### group_id #{group_id}")
    Rails.logger.debug("######contact #{contact.inspect}")
    Rails.logger.debug("###### advertisemetn #{advertisement.inspect}")

    AdHistory.create!(message: sent_message, 
                      group_id: group_id, 
                      contact_id: contact.id, 
                      sponsor_id: advertisement.sponsor_id)
  end

end
