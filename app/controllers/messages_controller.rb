require 'twilio-ruby'

class MessagesController < ApplicationController

  def new
    @message = Message.new
    @group = Group.find(params[:group_id])
    @message.group = @group
  end

  def deliver
    @message = Message.new(params[:message].permit(:message, :group_id))
    @contacts =  Group.find(@message.group_id).contacts
    
    @group = Group.find(@message.group_id)
    if @contacts.size == 0 
      flash[:alert] = "The message was not sent because the group doesn't have any contacts."
      redirect_to @group and return
    end
    render(:file => File.join(Rails.root, 'public/404'), :status => 404, :layout => false, content_type: "text/html" ) and return if @group.nil?
    @account_sid = ENV['TW_SID']
    @auth_token = ENV['TW_TOKEN']
    Rails.logger.debug "##### Set up a client to talk to the Twilio REST API using Twilio gem with #{@account_sid} #{@auth_token}"
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @message.group = @group
    # Some contact types require a fee (SMS & Phone, for example)  When messages are sent using those 
    #   contact methods a fee must be subtracted from the contributions.
    #   In addition, the sponsor from whom the contribution was subtracted will have their advertisement added to the
    #   sent message.
    if @group.exceed_messages?
      flash[:alert] = "The message cannot be sent because you have already sent #{@group.membership_level.allowed_messages} this month.  You must upgrade to a 'Premium' or 'Sponsored' level to be able to send additional messages."
      redirect_to @group and return
    end
    if @message.save
      Rails.logger.debug "##### Sending #{@message.inspect} to each contact"
      # Check membership, on Group model (ie., Group.messages_exceeded?) level before sending message
      # abort if number of messages exceeds threshhold

      @contacts.each do |c|
        case c.type
        when "Sms"
          body = "#{@message.group.name}: #{@message.message}\r\n\r\n#{Sponsor.getTextAd}"
          @twilioMessage = @client.account.sms.messages.create({
                                                                 :from => @group.twilio_number, 
                                                                 :to => c.entry, 
                                                                 :body => body
                                                               })
        when "Phone"
          sponsor_msg = Rack::Utils.escape(Sponsor.getPhoneAd)
          message = Rack::Utils.escape(@message.message)
          group = Rack::Utils.escape(@group.name)
          app_url = "#{request.protocol + request.host_with_port}" unless Rails.env.development?
          app_url = "http://nmc-demo.herokuapp.com" if Rails.env.development?
          url = "#{app_url}/twiml/say.xml?secret=#{ ENV['NMC_API_KEY'] }&IfMachine=Continue&message=#{message}&sponsor_msg=#{sponsor_msg}&group=#{group}"
          @call = @client.account.calls.create(  :from => @group.twilio_number,  :to => c.entry, :url => url, :method => 'GET' )
        when "Email"
          MessageMailer.send_message(c,@message).deliver
        else
        end
      end
      
    end
    flash.now[:notice] = "Message sent successfully to #{@contacts.size} contacts."
    render "groups/show", id: @group.id
  end

  def index
  end

end
