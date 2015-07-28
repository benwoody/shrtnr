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

  def update_api_key
    @settings = current_user
    if @settings.generate_api_key
      redirect_to settings_url, notice: 'Updated URL Key'
    else
      redirect_to settings_url, alert: "Failed to update api key"
    end
  end

  private

    def settings_params
      params.require(:settings).permit(:name, :email)
    end
end
