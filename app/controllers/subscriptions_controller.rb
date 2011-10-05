class SubscriptionsController < ApplicationController
  def new
    @subscription = Subscription.new
  end

  def edit
  end

  def show
  end

  def destroy
  end

  def create 
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save
      logger.info "I think we saved this"
      redirect_to @subscription, :notice => "Thank you for subscribing.."
    else
      render :action => 'new'
    end
  end

  def index
      logger.info "This is the index page"
    @subscriptions = Subscription.find(:all)
  end

def update
end

end
