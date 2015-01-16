class ContactsController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create, :opt_out]
  respond_to :html, :json

  def index
    authorize unless params[:group_id] 
    if params[:group_id]
      @group = current_user.groups.find(params[:group_id])
      @contacts = @group.contacts
    else
      @contacts = Contact.all
    end
  rescue
    Rails.logger.debug "##### You do not have access to group #{@group}"
    flash[:alert] = "You do not have access to this group."
    redirect_to root_path and return
  end

  def search
    if params[:entry]
      Rails.logger.info("##### Searching for contacts")
      normalized_entry = Phone.normalize_number(params[:entry], :default_country_number => '01')
      if Phony.plausible?(normalized_entry)
        Rails.logger.info("##### Searching for phone")
        contact = Contact.find_by_normalized_entry(normalized_entry)
      else 
        Rails.logger.info("##### Searching for email ")
        contact = Contact.find_by_entry(params[:entry])
      end
    else
      Rails.logger.info("##### Getting all contacts")
      @contacts = Contact.all
    end
    @contacts = [] if @contacts.nil?
    @contacts << contact unless contact.nil?

    Rails.logger.info("##### Contacts are #{@contacts.to_json}")
    respond_with(@contacts)
  end

  def show
    @contact = Contact.find(params[:id])
    @group = Group.find(params[:group_id]) if params[:group_id]
  end

  def new
    @contact = Contact.new

    if params[:user] && current_user
      Rails.logger.debug "##### Setting a user ID on this contact"
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
    Rails.logger.info "####### Contact now has #{@contact.groups.size} groups"
    unless params[:contact][:group].nil?  && params[:contact][:group][:id].nil?
      group_id = params[:contact][:group][:id]
      @group = Group.find(group_id)
      Rails.logger.info "##### Contact has groups #{@contact.groups.inspect}"
      @contact.groups.push(@group) unless @contact.groups.include?(@group)
    end
    
    if @contact.save && @contact.errors.size == 0
      @group = Group.find(group_id)
      
      redirect_to user_group_path(current_user, @group), :notice => "Successfully created contact" and return if current_user && @group.user == current_user
      redirect_to root_path, :notice => "We will let you know when something is posted for \"#{@group.name}\"." if !current_user || @group.user != current_user
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
