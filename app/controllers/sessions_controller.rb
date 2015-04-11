class SessionsController < ApplicationController
  include SessionsHelper
  
  def direct
    if signed_in?
      redirect_to dashboard_path
    else
      redirect_to home_path
    end
  end

  def new
  end

  def create
    user = User.where(email: params[:email]).first

    if user && params[:password].present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path, notice: "You have been logged in."
    else
      flash[:error] = "Your username, email or password are incorrect. Please try again."
      redirect_to login_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "You have been logged out."
  end
end
