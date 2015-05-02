class DashboardsController < ApplicationController
  include SessionsHelper
  include LinksHelper

  def index
    @links = current_user.links.reject { |l| l.short_url.blank? }
    @link = current_user.links.build
  end

  def home
    @link = Link.new
  end

  def all
    respond_to do |format|
      format.html { @links = Link.all }
      # format.html { @links = Link.includes(:user).all }
      format.json { @links = Link.all }
    end
  end
end
