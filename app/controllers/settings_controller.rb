class SettingsController < ApplicationController
  include SessionsHelper

  before_action :authentication_required
  before_action :get_settings, only: [:index, :new_api]

  def index
  end

  def update
    @settings = current_user
    if @settings.update_attributes(settings_params)
      SettingsMailer.update_email(@settings).deliver_now
      redirect_to settings_url, notice: "Successfully updated settings"
    else
      redirect_to settings_url, alert: "Failed to update settings"
    end
  end

  def new_api
    @settings.generate_api_key
    @settings.save
    redirect_to settings_url, notice: "You now have a new API key."
  end

  private

    def get_settings
      @settings = current_user
    end

    def settings_params
      params.require(:settings).permit(:name, :email)
    end
end
