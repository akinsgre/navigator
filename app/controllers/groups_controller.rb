class GroupsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :add_contact, :save_contact]
  respond_to :html, :json

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
    Rails.logger.debug "####### this group is #{@thisgroup.inspect}"
    begin
      Rails.logger.debug "##### GroupsController.show - params = #{params.inspect}"
      Rails.logger.debug "##### current_user has groups #{current_user.groups.inspect}"
      @group = current_user.groups.find(params[:id])
    rescue => e
      Rails.logger.debug "##### You don't have access to group #{e}"
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
    @group.user = current_user
  end

  def create
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
  params.require(:group).permit(:name, :description, :user_id, :sponsor_email)
end  

end
