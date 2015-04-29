class Api::V1::LinksController < Api::BaseController
  include LinksHelper

  before_action :authenticate_with_api_key

  def create
    param = { long_url: params[:url] }
    @link = @user.links.build(param)
    if @link.save
      render json: { shorturl: full_url(@link) }
    end
  end
  
  def show
    @link = Link.find(params[:id])
    @user = @link.user
    render :json => @link.as_json(:include =>[user: {only: [:name,:email]}])
  end
  
end
