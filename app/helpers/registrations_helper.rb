module RegistrationsHelper
  def verify_email_invite(email)
    Rails.logger.debug "##### Verifying login email is in the Invite list  is #{email.inspect}"
    return Invite.exists?(email: email)
  end
end
