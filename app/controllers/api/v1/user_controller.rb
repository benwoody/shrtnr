class Api::V1::UsersController < Api::BaseController
  include LinksHelper

  before_action :authenticate_with_api_key

  def show
    @user = User.find(params[:id])
    if @user?
      render json: { user: @user }
    else
      render json: { errors: @link.errors }
    end
  end
end
