class Api::V1::LinksController < Api::BaseController
  include LinksHelper

  before_action :authenticate_with_api_key

  def create
  	param = { long_url: params[:url] }
  	@link = @user.links.build(params)
  	if @link.save
  	  render json: { shorturl: full_url(@link) }
  	end
  end

  def show
  	@link = Link.find(params[:id])
  	@user = User.find(@link.user_id)

	render json: {
	  short_url: @link.short_url
	  long_url: @link.long_url
	  clicks: @link.clicks
	  user: {
	    name: @user.name
	    email: @user.email
	  }
	}
  end
end

