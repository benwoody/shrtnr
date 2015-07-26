class Api::V1::UsersController < Api::BaseController
  include UsersHelper #Still not sure what this helper does

  before_action :authenticate_with_api_key

  def show
    @user = User.find(params[:id])
    if @user.valid?
      render json: { 
        user: {
          name: @user.name,
          email: @user.email,
          links: @user.links 
        } 
      }
    else
      render json: { errors: @link.errors }
    end
  end
end
