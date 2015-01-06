class SponsorsController < ApplicationController
  layout 'megaboogie'
  before_filter :authenticate_admin!
  def index 
    @sponsors = Sponsor.all
    @menu_map = {"New Sponsor" => new_sponsor_path }

  end

  def new
    @sponsor = Sponsor.new
    @contribution = @sponsor.contributions.build
  end

  def create

    @sponsor = Sponsor.new(params.require(:sponsor).permit(:name, :email, :phone))
    
    @contribution = Contribution.new(params.require(:contribution).permit(:amount))
    #message cost
    @sponsor.messages_allowed = @contribution.amount/0.02 
    @contribution.sponsor = @sponsor

    if @sponsor.save
      redirect_to sponsors_path, :notice => "Successfully created sponsor."
    else
      render :action => 'new'
    end
  end

  def show
  end
end
