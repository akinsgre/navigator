class HelpController < ApplicationController
  def index
    
  end

  def show
    Rails.logger.debug "##### Help being found is #{params}"
    @help = Help.find_by_name(params[:id])
    render @help.name, :layout => false
  end
end
