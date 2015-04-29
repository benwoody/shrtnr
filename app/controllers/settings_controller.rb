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

  def regen_api_key
    if current_user.update_attributes(api_key: SecureRandom.hex(16))
      redirect_to settings_url, notice: "Your API key has been updated."
    else
      redirect_to settings_url, notice: "There was a problem updating your API key."
    end
  end

  private

    def settings_params
      params.require(:settings).permit(:name, :email)
    end
end
