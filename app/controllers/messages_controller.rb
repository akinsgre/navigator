require 'twilio-ruby'

class MessagesController < ApplicationController

  def new
    @message = Message.new
    @group = Group.find(params[:group_id])
    @message.group = @group
  end

  def deliver
    Rails.logger.debug "#### Delivering message using #{params}"
    Rails.logger.debug " Called from #{caller[0]}"
    
    @message = Message.new(params[:message].permit(:message, :group_id))
    @group = Group.find(@message.group_id)
    render(:file => File.join(Rails.root, 'public/404'), :status => 404, :layout => false, content_type: "text/html" ) and return if @group.nil?
    logger.debug "#### ID = " + @message.group_id.to_s
    @account_sid = ENV['TW_SID']
    @auth_token = ENV['TW_TOKEN']

    Rails.logger.debug "##### Set up a client to talk to the Twilio REST API using Twilio gem with #{@account_sid} #{@auth_token}"
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)

    # end of Twilio gem stuff
    Rails.logger.debug "##### Getting the contacts for #{@message.group_id}"

    @message.group = @group
    @contacts =  Group.find(@message.group_id).contacts

    # Some contact types require a fee (SMS & Phone, for example)  When messages are sent using those 
    #   contact methods a fee must be subtracted from the contributions.
    #   In addition, the sponsor from whom the contribution was subtracted will have their advertisement added to the
    #   sent message.
    if @message.save
      Rails.logger.debug "##### Sending #{@message.inspect} to each contact"
      # Check membership, on Group model (ie., Group.messages_exceeded?) level before sending message
      # abort if number of messages exceeds threshhold
      @contacts.each do |c|
        Rails.logger.debug "##### Contact is #{c.inspect}"
        Rails.logger.debug "##### Sending #{c.type} message to #{c.name} with #{@message.message} to #{@message.group.name}"

        Rails.logger.debug "Sending the message #{@message.message} to  #{c.type} : #{c.inspect}"

        case c.type
        when "Sms"
          body = "#{@message.group.name}: #{@message.message}\r\n\r\n#{Sponsor.getTextAd}"
          Rails.logger.debug "#### Send Text message #{body}"
          @twilioMessage = @client.account.sms.messages.create({
                                                                 :from => @group.twilio_number, 
                                                                 :to => c.entry, 
                                                                 :body => body
                                                               })

        when "Phone"
          Rails.logger.debug "#### Send Phone Call"
          sponsor_msg = Rack::Utils.escape(Sponsor.getPhoneAd)
          message = Rack::Utils.escape(@message.message)
          url = "http://notifymyclub.herokuapp.com/twiml/say.xml?secret=#{ ENV['NMC_API_KEY'] }&message=#{message}&sponsor_msg=#{sponsor_msg}&group=#{@group.name}"
          Rails.logger.info "##### Sending Message #{url}"
          @call = @client.account.calls.create(  :from => @group.twilio_number,  :to => c.entry, :url => url, :method => 'GET' )
          
        when "Email"
          Rails.logger.debug "#### Send Email"
          MessageMailer.send_message(c,@message).deliver
        else
        end

        
      end
      
    end

  end

  def index
  end

end
