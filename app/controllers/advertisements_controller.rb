class AdvertisementsController < ApplicationController
  def new
    @sponsor = Sponsor.find(params[:sponsor_id])
    @advertisement = @sponsor.advertisements.build
  end

  def index

  end

  def create
    @sponsor = Sponsor.find(params[:sponsor_id])

    @advertisement = Advertisement.new(  params.require(:advertisement).permit(:message, :html_message, :sponsor_id, :phone_message) )

    @advertisement.sponsor = @sponsor
      Rails.logger.debug "##### Place C"
    if @advertisement.save
      Rails.logger.debug "##### Saved the ad"
      respond_to do |format|
        format.html { redirect_to sponsors_path, :notice  => "Successfully created Advertisement." }
        format.js
      end
    else
      Rails.logger.debug "##### Failed to save the ad because #{@advertisement.errors.full_messages.inspect}"
      render :action => 'new'
    end
  end

  def update
      Rails.logger.debug "##### Updating"
    @sponsor = Sponsor.find(params[:sponsor_id])
    @advertisement = Advertisement.find(params[:id])
    if @advertisement.update_attributes(params[:advertisement].permit(:message, :html_message, :phone_message))
      respond_to do |format|
      Rails.logger.debug "##### Success"
        format.html { redirect_to sponsors_path, :notice  => "Successfully updated Advertisement." }
        format.js
      end
    else
      Rails.logger.debug "##### Failed to save the ad because #{@advertisement.errors.full_messages.inspect}"
      render :action => 'edit'
    end
  end

  def show
  end

  def edit
    @sponsor = Sponsor.find(params[:sponsor_id])
    @advertisement = Advertisement.find(params[:id])
  end
  def destroy
    @advertisement = Advertisement.find(params[:id])
    if @advertisement.destroy
      respond_to do |format|
        format.html { redirect_to sponsors_path, :notice  => "Successfully deleted Advertisement." }
        format.js
      end
    else
      Rails.logger.debug "##### Failed to delete"
      respond_to do |format|
        format.html { redirect_to sponsors_path, :alert  => "Unable to delete Advertisement." }
        format.js
      end
    end
  end
end
