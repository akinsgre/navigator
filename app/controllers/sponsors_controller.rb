class SponsorsController < ApplicationController
  def info
  end

  def new
    @group = Group.find(params[:group_id])
    @new_sponsor = @group.sponsors.build
    @contribution = @group.contributions.build

  end

  def create
    @group = Group.find(params[:group_id])
    @sponsor = Sponsor.new(params[:sponsor])
    @contribution = Contribution.new(params[:contribution])
    @contribution.sponsor = @sponsor
    @sponsor.groups.push(@group)

    @group.contributions.push(@contribution)
    if @sponsor.save
      redirect_to group_sponsor_path, :notice => "Successfully created sponsor."
    else
      render :action => 'new'
    end
  end

  def show
  end
end
