class SettingsController < ApplicationController
  include SessionsHelper

  before_action :authentication_required
  before_action :set_settings

  def index
  end

  def update
    if @settings.update_attributes(settings_params)
      respond_to :js
    else
      redirect_to settings_url, alert: "Failed to update settings"
    end
  end

  def regenerate_key
    current_user.generate_api_key
    current_user.save
    @updated_key = "http://shrtnr.com/api/v1/links/create?api_key=#{current_user.api_key}&url=%@"
    respond_to :js
  end

  private

    def set_settings
      @settings = current_user
    end

    def settings_params
      params.require(:settings).permit(:name, :email)
    end
end
