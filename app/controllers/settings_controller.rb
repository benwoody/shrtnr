# Settings controller class
class SettingsController < ApplicationController
  include SessionsHelper

  before_action :authentication_required

  def index
    @settings = current_user
  end

  def update
    @settings = current_user
    if @settings.update_attributes(settings_params)
      redirect_to settings_url, notice: 'Successfully updated settings'
    else
      redirect_to settings_url, alert: 'Failed to update settings'
    end
  end

  def api_key_regeneration
    @settings = current_user
    if @settings.update_attributes(:api_key => SecureRandom.hex(16))
      redirect_to settings_url, notice: 'New API key created'
    elsif
      redirect_to settings_url, notice: 'API key creation failed'
    end
  end

  private

  def settings_params
    params.require(:settings).permit(:name, :email)
  end
end
