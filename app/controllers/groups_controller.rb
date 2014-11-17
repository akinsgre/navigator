
class GroupsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :add_contact, :save_contact]
  respond_to :html, :json

  def index
    Rails.logger.debug "###### let's find some groups "
    @myGroups = current_user.mygroups unless current_user.nil?
    logger.info "##### Search parameters are " + params[:search].to_s unless params[:search].nil?
    if params[:search].nil?
      @groups = Group.all
    else
      @groups = Group.search(params[:search])
    end
    Rails.logger.debug "#### Show the groups #{@groups.inspect}"
    respond_with(@groups)
  end

  def show

    @group = Group.find(params[:id])
    @menu_map = { "Edit" => edit_group_path(@group), "Destroy" => url_for(:action => 'destroy', :controller => 'groups'), "View All" => groups_path }


    if @group.nil?
      redirect_to :root, :status => 401, :notice => "You do not have access to this group."
    end
    #    @contacts = @group.contacts.find(:all) unless @group.nil?
  end

  def new
    logger.info "Current User = " + current_user.email
    @group = Group.new
    @group.user = current_user
  end

  def create
    logger.debug "########### Creating a group with these parameters #{file_params}"
    #if there is a bulk_upload parameter parse it as a member list
    unless file_params["bulk_upload"].blank?
      Member.save(file_params["bulk_upload"])
    end
    @group = Group.new(group_params)
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
    Rails.logger.debug "#### Removing #{params.inspect}"
    if params[:contact_id] && @group.contacts.delete(Contact.find(params[:contact_id]))
      redirect_to @group, :notice  => "Successfully removed contact."
    else
      render :action => 'edit'
    end
  end
  def add_contact
    @group = Group.find(params[:id])
    @contact = Contact.new
  end

  def save_contact
    Rails.logger.info "###### Params #{params}"
    Rails.logger.info "Param contact = #{params[:contact].inspect}"

    @group = Group.find(params[:group][:id])

    @contact = Contact.new
    @contact.entry = params[:contact][:entry]
    @contact.identifier = params[:contact][:identifier]
    @group.contacts << @contact
    @group.save
    
    if @group.save && current_user
      redirect_to @group, :notice  => "Successfully updated group."
    elsif @group.save && !current_user
      redirect_to :root
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
  
private
def group_params
  params.require(:group).permit(:name, :description, :user_id, :sponsor_email)
end  
def file_params
  params.require(:group).permit(:bulk_upload)
end
end
