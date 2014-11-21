module RegistrationsHelper
  def verify_email_invite(email)
    Rails.logger.debug "##### Verifying login email is in the Invite list  is #{email.downcase.inspect}"
    return Invite.exists?(['lower(email) = ?', email.downcase])
  end
end
