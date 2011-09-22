require 'twilio-ruby'

class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def deliver
    @message = Message.new(params[:message])
    logger.info "ID = " + @message.group_id.to_s
    @account_sid = ENV['TW_SID']
    @auth_token = ENV['TW_TOKEN']

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @account = @client.account
    @contacts =  Group.find(@message.group_id).contacts

    @contacts.each do |c|
      logger.info "Sending message to " + c.phone + " with " + @message.message
      @twilioMessage = @account.sms.messages.create({:from => '+17249071027', :to => c.phone, :body => @message.message})
    end

  end

  def index
  end

end
