
class GroupsController < ApplicationController
  before_filter :authenticate_user!, :except => ['index']
  respond_to :html, :json

  def index

    @myGroups = Array.new
    if !current_user.nil? then
      current_user.contacts.each do |c|
      @myGroups += c.groups
      end
    end
    logger.info "Search parameters are " + params[:search].to_s unless params[:search].nil?
    if params[:search].nil?
      @groups = Group.search(params[:search])
    else
      @groups = Groups.all
    end
    respond_with(@groups)
  end

  def show
    @group = Group.find(params[:id])

    if @group.nil?
      redirect_to :root, :status => 401, :notice => "You do not have access to this group."
    end
    #    @contacts = @group.contacts.find(:all) unless @group.nil?
  end

  def new
    logger.info "Current User = " + current_user.email + " who is an admin (" + current_user.admin?.to_s  + ")"
    if current_user.admin? || current_user.subscribed?
      @group = Group.new
      @group.user = current_user
    else
      redirect_to :root, :notice => "Only premium subscribers can create groups."
    end
  end

  def create
    logger.info params[:group].name
    @group = Group.new(params[:group])
    if @group.save
      redirect_to @group, :notice => "Successfully created group."
    else
      render :action => 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    logger.info "Contact_id is " + params[:contact].to_s
    @contact = Contact.find(params[:contact])
    @group.contacts.push(@contact)
    if @group.save!
      respond_to do |format|
        format.html { redirect_to @group, :notice  => "Successfully updated group." }
        format.js
      end
    else
      render :action => 'edit'
    end
  end

  def remove_contact
    @group = Group.find(params[:id])
    if :contact_id && @group.contacts.delete(Contact.find(params[:contact_id]))
      redirect_to @group, :notice  => "Successfully removed contact."
    else
      render :action => 'edit'
    end
  end

  def add_contact
    logger.info "Param id = " + params[:id].to_s
    @group = Group.find(params[:id])
    if :contact_id && @group.contacts.add(Contact.find(params[:contact_id]))
      redirect_to @group, :notice  => "Successfully updated group."
    else
      render :action => 'edit'
    end
  end

  def join
    @group = Group.find(params[:id])
    
    render :partial => "join"
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_url, :notice => "Successfully destroyed group."
  end
end
