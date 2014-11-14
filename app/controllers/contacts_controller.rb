class ContactsController < AdminController
  before_filter :authenticate_user!, :except => [:new, :create]
  #before_filter :authorize, :only => [:index]
  def index
    authorize unless params[:group_id] 
    if params[:group_id]
      @group = Group.find(params[:group_id])
      @contacts = @group.contacts
    else
      @contacts = Contact.all
    end

  end
  
  def show
    @contact = Contact.find(params[:id])
    @group = Group.find(params[:group_id]) if params[:group_id]
  end

  def new
    @contact = Contact.new
    logger.info "User id will be " + params[:user_id].to_s

    unless params[:user_id].nil? || params[:user_id].to_s.rstrip.empty?
      @contact.user_id = params[:user_id] 
    end
    logger.info "Group id will be " + params[:group_id].to_s

    if !params[:group_id].nil? && Group.exists?(params[:group_id]) 
      @group = Group.find(params[:group_id]) 
      logger.info @group
    end
  end

  def create
    Rails.logger.debug "#### Params are #{params.inspect}"
    Rails.logger.debug "#### Params[:contact] are #{params[:contact].inspect}"
    contactType = params[:contact][:type]
    case  contactType 
    when'Phone'
      
      @contact = Phone.new(params[:contact].permit(:name, :user_id, :entry, :type))
    when 'Sms'
      
      @contact = Sms.new(params[:contact].permit(:name, :user_id, :entry, :type))
      
    when 'Email'
      
      @contact = Email.new(params[:contact].permit(:name, :user_id, :entry, :type))
      
    else
      Rails.logger.info "This #{@contact.class} is not a type"
      raise "Not a supported type"
    end
    
    Rails.logger.debug "##### Contact being created is #{@contact}"
    unless params[:contact][:group].nil?  && params[:contact][:group][:id].nil?
      group_id = params[:contact][:group][:id]
      logger.info "##### param Group[:id] is " + group_id
      group = Group.find(group_id)
      logger.info "##### Group is " + group.name
      @contact.groups.push(group)
    end

    logger.info "@contact #{@contact} has  " + @contact.groups.size.to_s + " groups."

    if @contact.save
      redirect_to group_contact_path(group, @contact) , :notice => "Successfully created contact." if current_user
      redirect_to root_path, :notice => "We will let you know when something is posted for \"#{group.name}." unless current_user
    else
      render "new"
    end

  end

  def edit
    @contact = Contact.find(params[:id])
    @group = Group.find(params[:group_id]) if params[:group_id]
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
