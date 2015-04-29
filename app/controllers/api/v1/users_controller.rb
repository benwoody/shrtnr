class Api::V1::UsersController < Api::BaseController
  include UsersHelper

  before_action :authenticate_with_api_key

  LinksCol = Struct.new(:short_url, :long_url, :clicks)

  def show
    @user = User.find(params[:id])
  
    if @user
      render json: {
        user: {
          name: @user.name,
          email: @user.email,
          links: @user.links.map { |link|
            LinksCol.new link.short_url, link.long_url, link.clicks
          }
        }
      }
    else
      render json: { error: "Invalid user ID" }
    end
  end
end
