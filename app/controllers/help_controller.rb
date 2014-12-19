class HelpController < ApplicationController
  def index
    
  end

  def show
    @help = Help.find_by_name(params[:id])
    render :layout => false
  end
end
