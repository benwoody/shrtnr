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
    @link = @user.links.find_by_short_url(params[:short_url])
    if @link
      render json: { 
        short_url: @link.short_url,
        long_url: @link.long_url,
        clicks: @link.clicks,
        user: {
          name: @user.name,
          email: @user.email
        }
      }
    else
      render json: { error: "invalid resource id" }
    end
  end
end
