class AdminController < ApplicationController
def admin?
  current_user.admin?
end

def authorize
  unless admin?
    flash[:error] = "Unauthorized access"
    redirect_to home_index_path
    false
  end
end
end

