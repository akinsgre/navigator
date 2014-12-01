class MessageMailer < ActionMailer::Base
  default from: "nmc@insomnia-consulting.org"

  def send_message(contact, message, advertisement)
    @contact = contact
    @message = message
    
    @sponsorMsg = advertisement.html_message

    mail(to: @contact.entry, subject: 'Message')
    @message
  end
end
