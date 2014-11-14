class MessageMailer < ActionMailer::Base
  default from: "nmc@insomnia-consulting.org"

  def send_message(contact, message)
    @contact = contact
    @message = message

    @sponsorMsg = Sponsor.getAd

    mail(to: @contact.entry, subject: 'Message')
    @message
  end
end
