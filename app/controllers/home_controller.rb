class HomeController < ApplicationController
  def index
Rails.logger.debug "###### What the fuck is happening here?"
    if user_signed_in? 
Rails.logger.debug "###### Need to sign in?"
      redirect_to user_path(current_user)
    else 
Rails.logger.debug "###### NSIgned in"
      render :index
    end

  end

end
