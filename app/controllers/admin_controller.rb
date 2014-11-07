class AdminController < ApplicationController
def admin?
  current_user.admin?
end

def authorize
  Rails.logger.debug "#####  Starting Authorize"
  unless admin?
    Rails.logger.debug "#####  Checking Authorize .. not an admin"
    flash[:error] = "Unauthorized access"
    redirect_to home_index_path and return false
  end
  Rails.logger.debug "#####  Ending Authorize authorized..."
end
end

