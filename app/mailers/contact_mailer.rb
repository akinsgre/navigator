class ContactMailer < ActionMailer::Base
  default from: "NotifyMyClub <info@notifymyclub.com>"

  def confirm_contact(contact)
    @contact = contact
    mail(to: @contact.entry, subject: "Please confirm your contact info.")
  end
end
