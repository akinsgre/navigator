module MessageHelper
  def record_message(sent_message, group, contact, advertisement)
    AdHistory.create!(message: sent_message, group_id: group.id, contact_id: contact.id, sponsor_id: advertisement.sponsor_id)
    advertisement.sponsor.update_attributes( messages_sent: advertisement.sponsor.messages_sent + 1)
  end
  def build_message(message, advertisement)
    template = "#{@message.group.name}: \r\n\r\n#{advertisement.message}\r\n\r\nReply \"STOP#{@message.group.id}\" to cancel"
    msg = []
    allowable_msg_length = 160 - template.length
    chunks = (message.length/allowable_msg_length)+1
    messageCount = 0
    chunks.times  do |b| 
      short_message = message[b*(allowable_msg_length),allowable_msg_length]
      body = "#{@message.group.name}: #{short_message}\r\n\r\n#{advertisement.message}\r\n\r\nReply \"STOP#{@message.group.id}\" to cancel"
      msg << body
      puts "######## #{body}"
    end
    return msg
  end
end
