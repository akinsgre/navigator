class AdvertisementsController < ApplicationController
  def new
    @sponsor = Sponsor.find(params[:sponsor_id])
    @advertisement = Advertisement.new
  end

  def index

  end

  def create
    @sponsor = Sponsor.find(params[:sponsor_id])
    @advertisement = Advertisement.new(  params.require(:advertisement).permit(:message, :html_message, :sponsor_id, :phone_message) )
    @advertisement.sponsor = @sponsor
    if @advertisement.save
      redirect_to sponsors_path
    else
      render :action => 'new'
    end
  end

  def update
  end

  def show
  end

  def edit
  end
end
