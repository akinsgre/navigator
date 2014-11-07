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
    logger.debug "#### ID = " + @message.group_id.to_s
    @account_sid = ENV['TW_SID']
    @auth_token = ENV['TW_TOKEN']

    Rails.logger.debug "##### Set up a client to talk to the Twilio REST API using Twilio gem with #{@account_sid} #{@auth_token}"
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)

    # end of Twilio gem stuff
    Rails.logger.debug "##### Getting the contacts for #{@message.group_id}"
    @contacts =  Group.find(@message.group_id).contacts

    # Some contact types require a fee (SMS & Phone, for example)  When messages are sent using those 
    #   contact methods a fee must be subtracted from the contributions.
    #   In addition, the sponsor from whom the contribution was subtracted will have their advertisement added to the
    #   sent message.
    Rails.logger.debug "##### Sending #{@message.inspect} to each contact"
    @contacts.each do |c|
      Rails.logger.debug "##### Contact is #{c.inspect}"
      Rails.logger.debug "##### Sending #{c.type} message to #{c.name} with #{@message.message} to #{@message.group.name}"
      # TODO send message per contacts type"
      Rails.logger.debug "Sending the message #{@message.message} to  #{c.type} : #{c.inspect}"
      case c.type
      when "Sms"
        Rails.logger.debug "#### Send Text message"
        @twilioMessage = @client.account.sms.messages.create({:from => '+17249071027', :to => c.entry, :body => @message.message})
      when "Phone"
        Rails.logger.debug "#### Send Phone Call"
        @call = @client.account.calls.create(  :from => '+17249071027',  :to => c.entry, :url => "http://localhost:3000/twiml/say.xml?secret=#{ ENV['NMC_API_KEY'] }" )
        
      when "Email"
        Rails.logger.debug "#### Send Email"
        MessageMailer.send_message(c,@message).deliver
      else
      end
      
    end

  end

  def index
  end

end
