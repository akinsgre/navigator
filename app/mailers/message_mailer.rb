class MessageMailer < ActionMailer::Base
  default from: "NotifyMyClub <info@notifymyclub.com>"

  def send_message(contact, message, advertisement)
    @contact = contact
    @message = message
    @sponsorMsg = advertisement.html_message
    mail(to: @contact.entry, subject: "Message from #{@message.group.name} ")
    @message
  end
end
