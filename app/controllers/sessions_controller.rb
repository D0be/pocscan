class SessionsController < ApplicationController
  
  def new
  end

  def create
    #login
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #loign successful
      log_in user
      #debugger
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      #login false
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    #logout
    log_out if logged_in?
    redirect_to root_url
  end
  
end
