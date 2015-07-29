class Api::V1::LinksController < Api::BaseController
  include LinksHelper

  before_action :authenticate_with_api_key

  def show
    @link = Link.find_by_short_url(params[:id])
    if @link
      render "show.json.jbuilder"
    else
      render json: { error: "Invalid short url" }
    end
  end

  def create
    param = { long_url: params[:url] }
    @link = @user.links.build(param)
    if @link.save
      render json: { shorturl: full_url(@link) }
    else
      render json: { errors: @link.errors }
    end
  end
end
