require 'twilio-ruby'

class MessagesController < ApplicationController
  include MessageHelper
  def new
    @advertisement = Sponsor.getAd
    @message = Message.new
    @group = Group.find(params[:group_id])
    @message.group = @group
  end


  def deliver
    @message = Message.new(params[:message].permit(:message, :group_id, :phone_message))
    @contacts =  Group.find(@message.group_id).contacts
    @group = Group.find(@message.group_id)
    @message.group = @group

    Rails.logger.debug ("##################### one")
        render(:file => File.join(Rails.root, 'public/404'), :status => 404, :layout => false, content_type: "text/html" ) and return if @group.nil?
    Rails.logger.debug ("##################### two")
    if @contacts.size == 0 
      flash[:alert] = "The message was not sent because the group doesn't have any contacts."
      redirect_to @group and return
    end
    Rails.logger.debug ("##################### three")
    # if @group.exceed_messages?
    #   flash[:alert] = "The message cannot be sent because you have already sent #{@group.membership_level.allowed_messages} this month.  You must upgrade to a 'Premium' or 'Sponsored' level to be able to send additional messages." 
    #   redirect_to @group and return
    # end


app_url = Navigator::Application.config.app_url
    Rails.logger.debug ("##################### URL #{app_url})
    if @message.save
      Rails.logger.info "##### Sending #{@message.inspect} to each contact"
      errors = 0
      @contacts.each do |c|
        DeliverWorker.perform_async(c.id, 
                                    @message.id, 
                                    Sponsor.getAd.id, 
                                    @group.id,
                                    {:app_url => app_url}
                                    )
      end
      flash.now[:notice] = "Message sent successfully to #{@contacts.size - errors } contacts."
      Rails.logger.warn "##### Did we make it here without an error?"
      render "groups/show", id: @group.id and return 
    end
  rescue => e
    Rails.logger.warn "##### There was a problem sending this message. #{e.message}"
    e.backtrace.each { |line| Rails.logger.debug line }
    flash.now[:alert] = "There was a problem sending this message. #{e.message}"
    render "groups/show", id: @group.id and return 
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
    record_message(sent_message, @group.id, @contact, advertisement ) unless sent_message.nil?
    Rails.logger.info "##### TwiML response = #{@message} and #{params[:AnsweredBy]}"
    if params[:AnsweredBy] == "human" && params[:say].blank?
      render :ask,  :layout => false
    else
      render :say,  :layout => false
    end
  end


end
