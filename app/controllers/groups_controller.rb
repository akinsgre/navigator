
class GroupsController < ApplicationController
before_filter :authenticate_user!
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    if @group.user == current_user 
      @contacts = @group.contacts.find(:all)
    end
  end

  def new

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

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_url, :notice => "Successfully destroyed group."
  end
end
