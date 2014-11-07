class MessageMailer < ActionMailer::Base
  default from: "nmc@insomnia-consulting.org"

  def send_message(contact, message)
    @contact = contact
    @message = message
    mail(to: @contact.entry, subject: 'Message')
  end
end
