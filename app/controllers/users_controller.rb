class UsersController < AdminController
  before_filter :authenticate_user! 


  def index

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    logger.debug "Trying to update user"
    @user = User.find(params[:id])
    logger.debug "Params " + params.to_s
    approved = params[:user][:approved]
    @user.approved = approved
    @user.email = params[:user][:email]
    if @user.save
      logger.info "this worked. approved = " + @user.approved.to_s
      redirect_to @user, :notice  => "Successfully updated user."
    else
      logger.info "Sorry .. it didn't work"
      render :action => 'edit'
    end
  end

  def show
    @subscriber = Subscription.find_by_user_id(current_user.id) 
    @following = current_user.following

    @groups = current_user.groups
    @otherGroups = @groups - @following
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, :notice => "Successfully destroyed user."
  end

end
