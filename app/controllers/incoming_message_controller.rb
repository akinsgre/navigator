class IncomingMessageController < ApplicationController
def receive
    authorized = params[:secret] && ( params[:secret] == ENV['NMC_API_KEY'])
    render(:file => File.join(Rails.root, 'public/403'), :status => 403, :layout => false, content_type: "text/xml" ) and return unless authorized
  render layout: false
end
end
