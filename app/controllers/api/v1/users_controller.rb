class Api::V1::UserssController < Api::BaseController
  include LinksHelper

  before_action :authenticate_with_api_key

  

  def show
    @user = User.find_by(email: params[:email])
    if @user.nil?
      render json: { errors: "No such user" }
    else
      render json: { user: @user, links: @user.links }
    end
  end

end
