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
    param = { id: params[:id] }
    @link = Link.find_by_short_url(param[:id])
    if @link
      render json: { shorturl: @link.short_url,
                    long_url: @link.long_url,
                    clicks: @link.clicks,
                    user:{
                      name: @link.user.name,
                      email: @link.user.email
                    }   
      }
    else
      render json: { errors: "invalid id" }
    end
  end

end
