class Api::V1::UsersController < Api::BaseController
  include UsersHelper

  before_action :authenticate_with_api_key

  def show
    @user = User.where(id: params[:id]).first
    
    if @user
      render json: {
                      user: {
                        name: @user.name,
                        email: @user.email,
                        links: @user.links.map{|l| 
                                  { 
                                    short_url: "http://shrt.nr" + l.short_url,
                                    long_url: l.long_url,
                                    clicks: l.clicks
                                  } 
                        }
                      }
      }
    else
      render json: { errors: "invalid id" }
    end
  end

end
