class SessionsController < ApplicationController

  def index

  end

  def new
  end

  def create
    user = User.find(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged In!"
    else
      flash.now[:alert] = "Invalid user email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged Out!"
  end

end
