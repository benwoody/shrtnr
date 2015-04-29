class Api::V1::UsersController < Api::BaseController
  include LinksHelper

  before_action :authenticate_with_api_key
  
  def show
    @user = User.find(params[:id])
    render :json => @user.as_json(:only => [:name,:email],:include =>[links: {only: [:short_url,:long_url,:clicks]}])
  end
  
end
