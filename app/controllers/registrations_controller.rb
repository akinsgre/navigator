class RegistrationsController < Devise::RegistrationsController
  include RegistrationsHelper

  def create
    if verify_email_invite(params[:user][:email])
      super
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash.now[:alert] = "Group Leader signup is invite-only at this time."
      render :new
    end
  end
  protected
  def after_sign_up_path_for(resource)
    '/groups/new'
  end
end

