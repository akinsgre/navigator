class MessageMailer < ActionMailer::Base
  default from: "NotifyMyClub <info@notifymyclub.com>"
  def send_message(contact, message, advertisement)
    @contact = contact
    @message = message
    @sponsorMsg = advertisement.html_message
    mail(to: @contact.entry, subject: "Message from #{@message.group.name} ")
    @message
  end
  def send_verification(contact)
    @token = SecureRandom.urlsafe_base64(nil, false)
    $redis.set(@token,contact.id)
    mail(to: contact.entry, subject: "Please verify your email address")
  end
end
