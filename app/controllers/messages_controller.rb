require 'twilio-ruby'

class MessagesController < ApplicationController
  include MessageHelper
  def new
    @message = Message.new
    @group = Group.find(params[:group_id])
    @message.group = @group
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
      Rails.logger.info "##### Sending #{@message.inspect} to each contact"
      # Check membership, on Group model (ie., Group.messages_exceeded?) level before sending message
      # abort if number of messages exceeds threshhold
      errors = 0
      # because localhost can't host the Twilio services
      if Rails.env.development?
        app_url = "http://nmc-demo.herokuapp.com" 
      else
        app_url = "#{request.protocol + request.host_with_port}"
      end
      @contacts.each do |c|
        advertisement = Sponsor.getAd
        sent_message = c.deliver( @message, advertisement, {:client => @client, :group => @group, :app_url => app_url})
        record_message(sent_message, @group, c, advertisement ) unless c.type == "FbGroup" || sent_message.nil?
      end
      flash.now[:notice] = "Message sent successfully to #{@contacts.size - errors } contacts."
      render "groups/show", id: @group.id      
    end
  rescue => e
    Rails.logger.warn "##### There was a problem sending this message. #{e.message}"
    e.backtrace.each { |line| Rails.logger.error line }
    flash.now[:alert] = "There was a problem sending this message. #{e.message}"
    render "groups/show", id: @group.id
  end

  def show
    @contact = Contact.find(params[:contact_id])
    @message = Message.find(params[:id])
    @group = Group.find(params[:group_id])

    if @message.phone_message.blank?
      @msg = @message.message
    else
      @msg = @message.phone_message
    end

    advertisement = Sponsor.getAd
    @sponsor_msg = advertisement.phone_message
    sent_message = advertisement.phone_message
    record_message(sent_message, @group, @contact, advertisement ) unless sent_message.nil?
    Rails.logger.info "##### TwiML response = #{@message} and #{params[:AnsweredBy]}"
    if params[:AnsweredBy] == "human" && params[:say].blank?
      render :ask,  :layout => false
    else
      render :say,  :layout => false
    end
  end


end
