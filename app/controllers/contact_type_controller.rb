class ContactTypeController < AdminController
  before_filter :authenticate_user!, :except => [:show]
  before_filter :authorize, :except => [:show]
  respond_to :json

  def index
    
  end

  def show
    selectedType = Object::const_get(params[:id]).long_description
    render json: selectedType.to_json
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end

end
