class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to home_path, :alert => "You are logged into karate tournament system."
    else
      flash.now[:alert] = "Email or password is invalid."
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash.now[:alert] = "You have been logged out."
    redirect_to home_path
  end
  
end
