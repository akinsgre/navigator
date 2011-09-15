class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index

    if params[:approved] == "false"
      @users = User.find_all_by_approved(false)
    else
      @users = User.all
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice  => "Successfully updated group."
    else
      render :action => 'edit'
    end
  end

  def show
    @user = User.find(params[:id])

  end
 def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, :notice => "Successfully destroyed user."
  end

end
