class IncomingMessageController < ApplicationController
  def receive
    authorized = params[:secret] && ( params[:secret] == ENV['NMC_API_KEY'])
    render(:file => File.join(Rails.root, 'public/403'), :status => 403, :layout => false, content_type: "text/xml" ) and return unless authorized
    number = params["From"]
    number  = Phony.normalize(number) unless number.nil?
    opt_out_success = false
    if params["SmsSid"] && params[:Body].include?("STOP")
      group_id = params[:Body].delete("STOP")
      contacts = Sms.all.where(:normalized_entry => '17244547790').select(:id)
      contacts.each do |c|

        group_contact = GroupContact.find_by_contact_id_and_group_id( c.id, group_id)
        unless group_contact.nil?
          group_contact.destroy 
          opt_out_success = true
        end
      end
    end

    if opt_out_success == false
      render(:file => File.join(Rails.root, 'public/404'), :status => 404, :layout => false, content_type: "text/xml" ) and return
    end
    render layout: false
  end
end
