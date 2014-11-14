class TwimlController < ApplicationController
  respond_to :xml, :html
  def say
    @message = params[:message]
    @sponsor_msg = params[:sponsor_msg]
    authorized = params[:secret] && ( params[:secret] == ENV['NMC_API_KEY'])
    render(:file => File.join(Rails.root, 'public/403'), :status => 403, :layout => false, content_type: "text/xml" ) unless authorized
  end
end
