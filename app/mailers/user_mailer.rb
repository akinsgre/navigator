class UserMailer < ActionMailer::Base
  default from: "NotifyMyClub <info@notifymyclub.com>"

  def request_invite(email)
    @message = "Please grant an invite to #{email}"
    mail(to: 'gakins@insomnia-consulting.org', subject: "Invite for NMC")
  end
end
