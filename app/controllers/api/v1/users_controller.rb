# Version 1 of API for usrer controller
class Api::V1::UsersController < Api::BaseController
  include LinksHelper
  before_action :authenticate_with_api_key

end
