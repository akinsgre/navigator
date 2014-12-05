class ContactsController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create, :opt_out]

  def index
    authorize unless params[:group_id] 
    if params[:group_id]
      @group = current_user.groups.find(params[:group_id])
      @contacts = @group.contacts
    else
      @contacts = Contact.all
    end
  rescue
    Rails.logger.debug "##### You don't have access to group #{@group}"
    flash[:alert] = "You don't have access to this group."
    redirect_to root_path and return
  end
  
  def show
    @contact = Contact.find(params[:id])
    @group = Group.find(params[:group_id]) if params[:group_id]
  end

  def new
    @contact = Contact.new

    if params[:user] && current_user
      Rails.logger.debug "##### Setting a user ID on this group"
      @contact.user_id = current_user.id
    end
    Rails.logger.info "##### Group id will be #{ params[:group_id]}.. and Contact is #{@contact}"

    if !params[:group_id].nil? && Group.exists?(params[:group_id]) 
      @group = Group.find(params[:group_id]) 
      Rails.logger.info "##### Found a group be #{@group}.. and Contact is #{@contact}"
      if @group.exceed_contacts?
        flash[:alert] = "This contact cannot be added because you have already added #{@group.membership_level.allowed_contacts}.  You must upgrade to a 'Premium' or 'Sponsored' level to be able to add additional contacts."
        @contact = nil
        redirect_to @group and return
      end
    else
      Rails.logger.info "##### Could not find Group #{params[:group_id]}"
      @contact = nil
      render(:file => File.join(Rails.root, 'public/404'), :status => 404, :layout => false, content_type: "text/html" ) and return
    end
    Rails.logger.debug "##### Group is #{@group} and Contact is #{@contact}"
  end

  def create
    @contact = Contact.determine_type(params)

    unless params[:contact][:group].nil?  && params[:contact][:group][:id].nil?
      group_id = params[:contact][:group][:id]
      @group = Group.find(group_id)
      logger.info "##### Group is " + @group.name
      @contact.groups.push(@group)
    end
    
    if @contact.save && @contact.errors.size == 0
      redirect_to group_path(@group), :notice => "Successfully created contact"  if current_user
      redirect_to root_path, :notice => "We will let you know when something is posted for \"#{@group.name}\"." unless current_user
    else
      Rails.logger.warn "##### New contact had errors #{@contact.errors.full_messages}"
      # Need to have a generic contact object on a new contact form.. 
      # otherwise the create method breaks when it tries to examine the params[:contact]
      @contact = @contact.becomes(Contact)
      render "new"

    end

  end

  def edit
    @contact = Contact.find(params[:id]).becomes(Contact)
    @group = Group.find(params[:group_id]) if params[:group_id]
  end

  def update
    # move all this garbage to the model.
    @group = Group.find(params[:group_id])
    @contact = Contact.determine_type(params)
    if @contact.errors.size == 0
      redirect_to group_contact_path(@group, @contact) , :notice => "Successfully updated contact." and return if current_user
      redirect_to root_path, :notice => "We will let you know when something is posted for \"#{@group.name}\"." and return unless current_user
    else
      @contact = @contact.becomes(Contact)
      render :action => 'edit'          
    end
  end

  def destroy
    @group = Group.find(params[:group_id]) if params[:group_id]
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to group_contacts_url(@group), :notice => "Successfully destroyed contact."
  end
  def opt_out
    contact = Contact.find(params[:contact_id])
    contact.destroy
  end
end
