class TwimlController < ApplicationController
  respond_to :xml
  def say
    @message = params[:message]
    authorized = params[:secret] && ( params[:secret] == ENV['NMC_API_KEY'])
    render(:file => File.join(Rails.root, 'public/403'), :status => 403, :layout => false) unless authorized
  end
end
