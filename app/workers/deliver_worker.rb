class DeliverWorker
  include Sidekiq::Worker, MessageHelper
  def perform(contact_id, message_id, advertisement_id, group_id, options)
    contact = Contact.find(contact_id)
    group = Group.find(group_id)
    options = options.merge({:group_id => group.id})
    Rails.logger.debug "######### OPTIONS Sent to Sidekiq : #{options.inspect}"
    advertisement = Advertisement.find(advertisement_id)
    sent_message = contact.deliver(message_id, advertisement, options)
    record_message(sent_message, group.id, contact, advertisement ) unless contact.type == "FbGroup" || sent_message.nil?
  end
end
