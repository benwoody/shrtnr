class Api::V1::LinksController < Api::BaseController
  include LinksHelper

  before_action :authenticate_with_api_key

  def create
    param = { long_url: params[:url] }
    @link = @user.links.build(param)
    if @link.save
      render json: { shorturl: full_url(@link) }
    else
      render json: { errors: @link.errors }
    end
  end

  def show
    @link = Link.find(params[:id])
    @user = User.find(@link.user_id)
    if @link && @user
      render json:  { 
        short_url: full_url(@link), 
        long_url: @link.long_url, 
        clicks: @link.clicks, 
        user: {
          name: @user.name, 
          email: @user.email
        }
      }
    else
      render json: { error: "Invalid link ID" }
    end
  end
end
