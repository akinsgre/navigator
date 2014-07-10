require 'twilio-ruby'

class MessagesController < ApplicationController

  def new
    @message = Message.new
    @message.group = Group.find(params[:id])
  end

  def deliver
    Rails.logger.debug "#### Delivering message using #{params}"
    Rails.logger.debug " Called from #{caller[0]}"
    
    @message = Message.new(params[:message].permit(:message, :group_id))
    logger.info "ID = " + @message.group_id.to_s
    @account_sid = ENV['TW_SID']
    @auth_token = ENV['TW_TOKEN']

    Rails.logger.debug "##### Set up a client to talk to the Twilio REST API using Twilio gem with #{@account_sid} #{@auth_token}"
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @account = @client.account
    # end of Twilio gem stuff
    Rails.logger.debug "##### Getting the contacts for #{@message.group_id}"
    @contacts =  Group.find(@message.group_id).contacts

    # Some contact types require a fee (SMS & Phone, for example)  When messages are sent using those 
    #   contact methods a fee must be subtracted from the contributions.
    #   In addition, the sponsor from whom the contribution was subtracted will have their advertisement added to the
    #   sent message.
    Rails.logger.debug "#####  Sending to each contact"
    @contacts.each do |c|
      logger.info "Sending " + c.type + 
        " message to " + c.name + " : " + c.phone + 
        " with " + @message.message + " to " + message.group.name
      # TODO send message per contacts type"
      Rails.logger.debug "Sending the message #{@message.message} to  #{c.type} : #{c.inspect}"
      case c.type
      when "Sms"
        Rails.logger.debug "#### Send Text message"
        # @twilioMessage = @account.sms.messages.create({:from => '+17249071027', :to => c.phone, :body => @message.message})
      when "Phone"
        Rails.logger.debug "#### Send Phone Call"
        # @twilioMessage = @account.sms.messages.create({:from => '+17249071027', :to => c.phone, :body => @message.message})
      when "Email"
        Rails.logger.debug "#### Send Email"
        # send mai
      else
      end
      
    end

  end

  def index
  end

end
