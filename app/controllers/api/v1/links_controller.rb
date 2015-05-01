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

#   def show
#       param = { long_url: params[:url] }
#       @link = @user.links.build(param)
#   		render json: { shorturl: full_url(@link), long_url: @link.long_url, clicks: @link.clicks, user: @user.name, user: @user.email }
#         # json.user do |json|
#         #   json.name @link.user.name
#         #   json.email @link.user.email
#         # end
      
#   end
end
