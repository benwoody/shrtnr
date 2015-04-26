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

  def regenerate_api_key
    if current_user.update_attributes(:api_key => SecureRandom.hex(16))
      redirect_to settings_url, notice: "API Key Updated"
    elsif
      redirect_to settings_url, notice: "API Key Update Failed"
    end     
  end

  private

    def settings_params
      params.require(:settings).permit(:name, :email)
    end
end
