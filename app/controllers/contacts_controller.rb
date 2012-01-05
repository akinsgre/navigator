class ContactsController < AdminController
before_filter :authenticate_user!
before_filter :authorize, :only => [:index]
  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new
    logger.info "User id will be " + params[:user_id].to_s

    unless params[:user_id].nil? || params[:user_id].to_s.rstrip.empty?
      @contact.user_id = params[:user_id] 
    end
    logger.info "Group id will be " + params[:group_id].to_s
    @group = Group.find(params[:group_id])
    @contact.groups.push(@group)
#    @existingContacts = []
  end

  def create
    @contact = Contact.new(params[:contact])
    logger.info "param Group[:id] is " + params[:group]["id"]
    group = Group.find(params[:group]["id"])
    logger.info "Group is " + group.name
    @contact.groups.push(group)
    if @contact.save
      redirect_to @contact , :notice => "Successfully created contact."
    else
      render :action => 'new'
    end

  end

  def edit
    @contact = Contact.find(params[:id])
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
