class SettingsController < ApplicationController
  include SessionsHelper

  before_action :authentication_required

  def index
    @settings = current_user
  end

  def update
    @settings = current_user
    if settings_params[:email] =~ /^.+@.+$/ && @settings.update_attributes(settings_params)
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
