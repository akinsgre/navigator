class TwimlController < ApplicationController
  respond_to :xml, :html
  def say
    @message = params[:message]
    @group = params[:group]
    @sponsor_msg = params[:sponsor_msg]
    authorized = params[:secret] && ( params[:secret] == ENV['NMC_API_KEY'])
    Rails.logger.info "##### TwiML response = #{@message} and #{@sponsor_msg}"
    render(:file => File.join(Rails.root, 'public/403'), :status => 403, :layout => false, content_type: "text/xml" ) unless authorized
    if params[:AnsweredBy]
      render :say
    else
      render :human_check
    end
  end
end
