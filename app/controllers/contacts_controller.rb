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

    if !params[:group_id].nil? && Group.exists?(params[:group_id]) 
      @group = Group.find(params[:group_id]) 
      logger.info @group
    end
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.type = params[:contact][:type]

    unless params[:contact][:group].nil? || params[:contact][:group][:id].nil?
      group_id = params[:contact][:group][:id]
      logger.info "param Group[:id] is " + group_id
      group = Group.find(group_id)
      logger.info "Group is " + group.name
      @contact.groups.push(group)
    end
    case @contact.type 
    when "Phone" 
      @typedContact = @contact.becomes(Phone)
    when "Sms"
      @typedContact = @contact.becomes(Sms)
    else 
      logger.info "This " + @contact.type + " is not a type"
      raise "Not a supported type"
    end
    logger.info "@contact has  " + @contact.groups.size.to_s + " groups."
    @typedContact.groups = @contact.groups
    logger.info "@typedContact has  " + @typedContact.groups.size.to_s + " groups."
    if @typedContact.save
      redirect_to @contact , :notice => "Successfully created contact."
    else
      #Move the errors from typedContact because @contact is going to be
      # used in the _form after the call to render
      @typedContact.errors.each do |attr, msg|
        @contact.errors.add(attr, msg)
      end
      render "new"
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
