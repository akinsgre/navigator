class IncomingMessageController < ApplicationController
  def receive
    authorized = params[:secret] && ( params[:secret] == ENV['NMC_API_KEY'])
    render(:file => File.join(Rails.root, 'public/403'), :status => 403, :layout => false, content_type: "text/xml" ) and return unless authorized
    number = params["From"]
    number  = Phony.normalize(number) unless number.nil?
    puts "##### OK.. we found a number #{number}"
    if params["SmsSid"] && params[:Body] == "STOP"
      contact = Sms.find_by_normalized_entry(number)
      puts "#### OK..we'll try to find #{contact}"
    elsif params["CallSid"]
      contact = Phone.find_by_normalized_entry(number)
      puts "#### OK..we'll try to find #{contact}"
    end
    if contact.nil?
      puts "#### Couldn't find "
      render(:file => File.join(Rails.root, 'public/404'), :status => 404, :layout => false, content_type: "text/xml" ) and return
    else
      contact.destroy
    end
    render layout: false
  end
end
