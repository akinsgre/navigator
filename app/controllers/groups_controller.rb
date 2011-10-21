
class GroupsController < ApplicationController
before_filter :authenticate_user!
  def index
    if current_user.admin?
      @groups = Group.all
    else
      @groups = current_user.groups
    end
  end

  def show
    if current_user.admin?
      @group = Group.find(params[:id])
    else
      @group = Group.owned_by(current_user.id).find(params[:id])
    end
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
    logger.info params[:group]
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

    if @group.update_attributes(params[:group])
      redirect_to @group, :notice  => "Successfully updated group."
    else
      render :action => 'edit'
    end
  end

  def remove_contact
    @group = Group.find(params[:id])
    if :contact_id && @group.contacts.delete(Contact.find(params[:contact_id]))
      redirect_to @group, :notice  => "Successfully updated group."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_url, :notice => "Successfully destroyed group."
  end
end
