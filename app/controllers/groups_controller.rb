class GroupsController < ApplicationController
  include GroupsHelper

  before_filter :authenticate_user!, :except => [:index, :add_contact, :save_contact]
  respond_to :html, :json
  #POST

  def add_admin
    Rails.logger.debug "############## We started"
    user = User.find_by_email(params[:email])
    group = current_user.groups.find(params[:group_id])
    group.users << user
    Rails.logger.debug "We got here"
    if group.save
    Rails.logger.debug "We got here 2"
      render :json => {'status' => 'success', 'message' => "#{user.email} was successfully added as an administrator."}
    else
      render :json => {'status' => 'failure', 'message' => "#{user.email} was not added as an administrator."}
    end
    Rails.logger.debug "We got here 3"
  rescue ActiveRecord::RecordNotFound => e1
    e1.backtrace.each { |line| Rails.logger.error line }
    Rails.logger.error "####### An error occurred #{e1.inspect}"
    render :json => {'status' => 'failure', 'message' => "#{params[:email]} is not a current user."}
  rescue Exception => e2
    e2.backtrace.each { |line| Rails.logger.error line }
    render :json => {'status' => 'failure', 'message' => "An error occurred. The site administrator has been notified.  Please try again. #{e2.inspect} "}
  end

  def index
    Rails.logger.debug "###### let's find some groups "
    @myGroups = current_user.mygroups unless current_user.nil?
    @myGroups ||= []
    logger.debug "##### Search parameters are " + params[:search].to_s unless params[:search].nil?
    if params[:search].nil?
      @groups = Group.all
    else
      @groups = Group.search(params[:search])
    end
    Rails.logger.debug "#### Show the groups #{@groups.inspect}"
    respond_with(@groups)
  end

  def show
    @thisgroup = Group.find(params[:id])
    Rails.logger.info "####### this group is #{@thisgroup.inspect}"
    begin
      Rails.logger.info "##### GroupsController.show - params = #{params.inspect}"
      Rails.logger.info "##### current_user has groups #{current_user.groups.inspect}"
      @group = current_user.groups.find(params[:id])
      Rails.logger.info "##### current_user has group #{@group.inspect}"
    rescue => e
      Rails.logger.info "##### You don't have access to group #{e}"
      flash[:alert] = "You don't have access to this group."
      redirect_to root_path and return
    end
    @menu_map = {"My Groups" => user_path(current_user),  "Edit" => edit_group_path(@group), "Remove Group" => url_for(:action => 'destroy', :controller => 'groups') }


    if @group.nil?
      redirect_to :root, :status => 401, :notice => "You do not have access to this group."
    end
    #    @contacts = @group.contacts.find(:all) unless @group.nil?
  end

  def new
    logger.debug "Current User = " + current_user.email
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    @group.users << User.find(params[:user_id])
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

    if @group.update_attributes(params[:group].permit(:name, :description))
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



  def join
    @group = Group.find(params[:id])
    
    render :partial => "join"
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] =  "Successfully destroyed group."
    redirect_to current_user
  end
  
private
def group_params
  params.require(:group).permit(:name, :description, :sponsor_email)
end  

end
