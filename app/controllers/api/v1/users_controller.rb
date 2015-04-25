class Api::V1::UsersController < Api::BaseController
  include LinksHelper

  before_action :authenticate_with_api_key
  
  def show
    @user = User.find(params[:id])
    @links = []
    @user.links.each do |link|
      @links << JSON.parse(link.to_json(:only => [:short_url, :long_url, :clicks]))
    end
    
    render json:  {:name => @user.name, :email => @user.email, :links => @links }
  end
  
end
