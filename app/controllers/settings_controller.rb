class SettingsController < ApplicationController
  include SessionsHelper

  before_action :authentication_required

  def index
    @settings = current_user
  end

  def update
    @settings = current_user
    if @settings.update_attributes(settings_params)
      redirect_to settings_url, notice: "Successfully updated settings"
    else
      redirect_to settings_url, alert: "Failed to update settings"
    end
  end
  
  def regenkey
    @user = current_user
    @user.generate_api_key
    @user.save
    redirect_to settings_url, alert: "Your api key has been updated, all previous key will be obsolete!"
  end

  private

    def settings_params
      params.require(:settings).permit(:name, :email)
    end
end
