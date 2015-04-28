class Api::V1::UsersController < Api::BaseController
  include LinksHelper

  before_action :authenticate_with_api_key

  LinkTuple = Struct.new(:short_url, :long_url, :clicks)

  def show
    render json: {
      user: {
        name: @user.name,
        email: @user.email,
        links: @user.links.map { |link| LinkTuple.new(link.short_url, link.long_url, link.clicks) }
      }
    }
  end

end