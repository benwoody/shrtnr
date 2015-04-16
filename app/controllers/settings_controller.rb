class SettingsController < ApplicationController
  include SessionsHelper

  before_action :authentication_required

  def index
    @settings = current_user
  end

  def twitter
    auth = request.env["omniauth.auth"] 
    current_user.find_or_create_by_uid(auth['uid'])
    #missing something here. Do I need to crate a new model to handle authentications? Why does it not recognize uid?

    redirect_to dashboard_path, notice: "twitter has been authorized."
  end

  def update
    @settings = current_user
    if @settings.update_attributes(settings_params)
      redirect_to settings_url, notice: "Successfully updated settings"
    else
      redirect_to settings_url, alert: "Failed to update settings"
    end
  end

  private

    def settings_params
      params.require(:settings).permit(:name, :email)
    end
end
