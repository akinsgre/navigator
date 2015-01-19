class InvitesController < ApplicationController
  respond_to :html, :json
  def create
    UserMailer.request_invite(params[:email]).deliver
    render :json => "An invite has been requested".to_json
  end
end
