class SettingsController < ApplicationController
  include SessionsHelper

  before_action :authentication_required

  def index
    @settings = current_user
  end

  def update
    @settings = current_user
    previous_settings = @settings.dup
    if @settings.update_attributes(settings_params)
      SettingsMailer.settings_change_email(@settings, previous_settings).deliver_now
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
