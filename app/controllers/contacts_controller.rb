class ContactsController < ApplicationController
before_filter :authenticate_user!
  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
    @contact.group_id = params[:group_id] 
    @contact.user_id = params[:user_id] 
  end

  def create
    @contact = Contact.new(params[:contact])
    logger.info "Email entered is " + @contact.email
    @user = User.new
    @user.email = @contact.email
    @user.password = ActiveSupport::SecureRandom.base64(12)
    
    if @contact.save && @user.save
      redirect_to @contact, :notice => "Successfully created contact."
    else
      render :action => 'new'
    end

  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def deactivate
  end

  def update
    @contact = Contact.find(params[:id])
    @user = User.find_by_email(params[:email])
    @user.email = @contact.email
    logger.info "Updating user " + @user.email
    if @contact.update_attributes(params[:contact]) && @user.save
      redirect_to @contact, :notice  => "Successfully updated contact."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to contacts_url, :notice => "Successfully destroyed contact."
  end
end
