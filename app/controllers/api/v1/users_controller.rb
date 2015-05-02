# Version 1 of API for usrer controller
class Api::V1::UsersController < Api::BaseController
  include LinksHelper

  before_action :authenticate_with_api_key

  def show
    @user = User.find(params[:id])
    if @user
      @linkset = []
      @user.links.each do |l|
        @linkset << JSON.parse(l.to_json(only: [:short_url, :long_url, :clicks]))
      end
      render json: { name: @user.name, email: @user.email, links: @linkset }
    else
      render json: { error: 'Invalid user or user id' }
    end
  end

end
