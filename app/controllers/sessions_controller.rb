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

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "You have been logged out."
  end

  def twitter
    auth = request.env["omniauth.auth"]
    if current_user
      current_user.update_attribute(:uid, auth["uid"])
      flash[:notice] = "You have now linked to your Twitter account."
      redirect_to settings_path
    else
      if (User.where(uid: auth["uid"]).first || User.from_twitter(auth))
        session[:user_id] = user.id
        flash[:notice] = "You have logged-in through your Twitter account."
        redirect_back_or root_url
      end
    end
  end
end
