class ContactTypeController < ApplicationController
  before_filter :authenticate_user!, :authorize, :admin
  def index
  end

  def show
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
