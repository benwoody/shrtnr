class Api::V1::UsersController < Api::BaseController
  include UsersHelper

  before_action :authenticate_with_api_key

  LinkStruct = Struct.new(:short_url, :long_url, :clicks)

  def show
  	@user = User.find(params[:id])

  	render json: {
  	  user: {
  	  	name: @user.name
  	  	email: @user.email
  	  	links: @user.links.map do |link|
  	  	  LinkStruct.new(link.short_url, link.long_url, link.clicks)
  	  	end
  	  }
  	}
  end
end

