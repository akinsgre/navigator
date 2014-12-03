class IncomingMessageController < ApplicationController
  def receive
    authorized = params[:secret] && ( params[:secret] == ENV['NMC_API_KEY'])
    render(:file => File.join(Rails.root, 'public/403'), :status => 403, :layout => false, content_type: "text/xml" ) and return unless authorized
    number = params["From"]
    number  = Phony.normalize(number) unless number.nil?

    if params["SmsSid"] && params[:Body].include?("STOP")
      group_id = params[:Body].delete("STOP")
      
      contact = Sms.find_by_normalized_entry(number)
      group_contact = GroupContact.find_by_contact_id_and_group_id( contact.id, group_id)
      group_contact.destroy unless group_contact.nil?
    elsif params["CallSid"]
      #Need to figure out how to get input from incoming phone numbers
      contact = Phone.find_by_normalized_entry(number)
      contact.destroy unless contact.nil?
      # group_contact = GroupContact.find_by_contact_id_and_group_id( contact.id, group_id)
      # group_contact.destroy

    end
    if contact.nil?
      render(:file => File.join(Rails.root, 'public/404'), :status => 404, :layout => false, content_type: "text/xml" ) and return
    end
    render layout: false
  end
end
