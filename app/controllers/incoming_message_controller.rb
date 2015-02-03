class IncomingMessageController < ApplicationController
  def receive
    authorized = params[:secret] && ( params[:secret] == ENV['NMC_API_KEY'])
    render(:file => File.join(Rails.root, 'public/403'), :status => 403, :layout => false, content_type: "text/xml" ) and return unless authorized
    number = params["From"]
    number  = Phony.normalize(number) unless number.nil?
    opt_out_success = false
    if params["SmsSid"] && params[:Body].include?("STOP")
      group_id = params[:Body].delete("STOP")
      normalized_entry = Phone.normalize_number(params[:From], :default_country_number => '01')
      contacts = Sms.all.where(:normalized_entry => normalized_entry).select(:id)
      contacts.each do |c|
        group_contact = GroupContact.find_by_contact_id_and_group_id( c.id, group_id)
        unless group_contact.nil?
          group_contact.destroy 
          opt_out_success = true
        end
      end
    end
    if params["SmsSid"] && params[:Body].include?("VERIFY")
      contact_id = params[:Body].delete("VERIFY")
      normalized_entry = Phone.normalize_number(params[:From], :default_country_number => '01')
      contacts = Sms.all.where(:normalized_entry => normalized_entry)
      contacts.each do |c|
        c.verify
        opt_out_success = true         if c.save
      end
    end

    if opt_out_success == false
      render(:file => File.join(Rails.root, 'public/404'), :status => 404, :layout => false, content_type: "text/xml" ) and return
    end
    render layout: false
  end
end
