require 'twilio-ruby'

class MessagesController < ApplicationController
  include MessageHelper
  def new
    @message = Message.new
    @group = Group.find(params[:group_id])
    @message.group = @group
    @fbGroupIds = ''
    @fbMessageExists = false
    @group.contacts.each do |c|
        advertisement = Sponsor.getAd
        Rails.logger.info "####### Advertisment is #{advertisement.inspect}"
        fbPermissions = false
        Rails.logger.info "####### Contact is #{c.type}"

        case c.type
        when "FbGroup"
          Rails.logger.debug "##### Sending a FB message"
          @fbMessageExists = true
          @fbMessage = "#{@group.name} : #{@message.message} : #{advertisement.message}"
          @fbGroupIds += "#{c.entry}#{',' unless c == @group.contacts.last} " 
        end
      end
  end

  def deliver
    @message = Message.new(params[:message].permit(:message, :group_id, :phone_message))
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

    if @group.exceed_messages?
      flash[:alert] = "The message cannot be sent because you have already sent #{@group.membership_level.allowed_messages} this month.  You must upgrade to a 'Premium' or 'Sponsored' level to be able to send additional messages."
      redirect_to @group and return
    end
    if @message.save

      Rails.logger.debug "##### Sending #{@message.inspect} to each contact"
      # Check membership, on Group model (ie., Group.messages_exceeded?) level before sending message
      # abort if number of messages exceeds threshhold
      errors = 0
      @contacts.each do |c|
        advertisement = Sponsor.getAd
        Rails.logger.info "####### Advertisment is #{advertisement.inspect}"
        fbPermissions = false
        Rails.logger.info "####### Contact is #{c.type}"
        @fbMessageExists = false
        case c.type
        when "FbGroup"
          Rails.logger.debug "##### Sending a FB message"
        when "Sms"
          #Twilio 160 character message limit
          message = ''
          
          message = "#{@message.message}"
          #split message into 160 character (Twilio limit) chunks
          messages = build_message(message, advertisement)
          messages.each do |msg|
            @twilioMessage = @client.account.sms.messages.create({
                                                                   :from => @group.twilio_number, 
                                                                   :to => c.entry, 
                                                                   :body => msg
                                                                 })
          end
          sent_message = advertisement.message
        when "Phone"
          sponsor_msg = Rack::Utils.escape(advertisement.phone_message)
          if @message.phone_message.blank?
            message = Rack::Utils.escape(@message.message)
          else
            message = Rack::Utils.escape(@message.phone_message)
          end
          sent_message = sponsor_msg
          group = Rack::Utils.escape(@group.name)
          app_url = "#{request.protocol + request.host_with_port}" unless Rails.env.development?
          app_url = "http://nmc-demo.herokuapp.com" if Rails.env.development?
          url = "#{app_url}/twiml/say.xml?secret=#{ ENV['NMC_API_KEY'] }&IfMachine=Continue&message=#{message}&sponsor_msg=#{sponsor_msg}&group=#{group}"
          @call = @client.account.calls.create(  :from => @group.twilio_number,  :to => c.entry, :url => url, :method => 'GET' )
        when "Email"
          MessageMailer.send_message(c,@message, advertisement).deliver
          sent_message = advertisement.html_message
        else
        end
        record_message(sent_message, @group, c, advertisement ) unless c.type == "FbGroup"
      end
      flash.now[:notice] = "Message sent successfully to #{@contacts.size - errors } contacts."
      render "groups/show", id: @group.id      
    end
  rescue => e
    flash.now[:alert] = "There was a problem sending this message. #{e.message}"
    render "groups/show", id: @group.id
  end

  def index
  end

end
