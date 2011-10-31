class EmailController < ApplicationController
  def create
    email = params[:email]
    
    if Email.create!({:email => email })
      render "success"
    else
      render "fail"
    end
  end

end
