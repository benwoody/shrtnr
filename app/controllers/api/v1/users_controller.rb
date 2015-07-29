class Api::V1::UsersController < Api::BaseController
  before_action :authenticate_with_api_key

  def show
    @user = User.find_by_id(params[:id])
    if @user
      render "show.json.jbuilder"
    else
      render json: { error: "Invalid id" }
    end
  end
end
