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
      flash[:error] = "Your username or password are incorrect. Please try again."
      redirect_to login_url
    end
  end

  def twitter
    # raise request.env["omniauth.auth"].to_yaml
    auth = request.env["omniauth.auth"]
    if signed_in?
      user = current_user
      user.update_with_twitter(auth)
      notice = "Your account is now linked with your Twitter account."
      redirect_url = settings_url
    else
      user = User.where(uid: auth["uid"]).first || User.from_twitter(auth)
      notice = "You have been logged in through Twitter."
      redirect_url = root_url
    end
    session[:user_id] = user.id
    flash[:notice] = notice
    redirect_back_or redirect_url
  end

  def failure
    if signed_in?
      alert = "Unable to link your account with your Twitter account."
      redirect_url = settings_url
    else
      alert = "Authentication Failed"
      redirect_url = root_url
    end
    flash[:alert] = alert
    redirect_back_or redirect_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "You have been logged out."
  end
end
