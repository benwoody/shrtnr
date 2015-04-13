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
    add_twitter = session[:add_twitter]
    session.delete :add_twitter

    auth = request.env["omniauth.auth"]

    # sign in via twitter
    user = User.where(uid: auth["uid"]).first
    if user
      if add_twitter
        # trying to add a twitter uid, but another user is already using it
        flash[:alert] = "You've already created a shrtnr account using this Twitter id"
        redirect_to settings_url #, error: "You've already created a shrtnr account using this Twitter id"
      else
        session[:user_id] = user.id
        flash[:notice] = "You have been logged in through Twitter."
        redirect_back_or root_url
      end
    else
      if add_twitter
        # adding twitter credentials to the current user
        user = current_user
        if user
          user.uid = auth["uid"]
          if user.save
            flash[:notice] = "You have added Twitter credentials to your account"
            redirect_back_or root_url
          else
            flash[:alert] = "Failed to add Twitter credentials to your account"
            redirect_back_or root_url
          end
        end
      else
        # creating a new user from a twitter id
        user = User.from_twitter(auth)
        session[:user_id] = user.id
        flash[:notice] = "You have created an account using your Twitter id."
        redirect_back_or root_url
      end
    end
  end

  def failure
    flash[:alert] = "Authentication Failed"
    redirect_back_or root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "You have been logged out."
  end
end
