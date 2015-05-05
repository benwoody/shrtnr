# Links controller class
class LinksController < ApplicationController
  include LinksHelper
  include SessionsHelper

  before_action :find_link, only: [:show, :redirection]

  def create
    url = Link.find_by_long_url(params[:link][:long_url])

    if url.blank?
      if signed_in?
        @link = current_user.links.build(link_params)
      else
        @link = Link.new(link_params)
      end
    else
      if signed_in?
        @link = current_user.links.build(link_params)
      else
        redirect_to link_path(url.short_url)
        return
      end
    end

    if @link.save
      create_tweet
      redirect_to link_path(@link.short_url), notice: 'URL added'
    else
      flash[:error] = 'Your URL was not valid'
      redirect_to root_url
    end
  end

  def show
  end

  def redirection
    @link.clicks += 1
    @link.save
    redirect_to @link.long_url
  end

  private

  def find_link
    @link = Link.find_by_short_url(params[:id])
  end

  def link_params
    params.require(:link).permit(:long_url, :tweet)
  end

  def create_tweet
    if current_user && signed_in_through_twitter? && params[:link][:tweet] == '1'
      text = "Check out my new link: #{full_url(@link)}"
      TwitterJob.perform_later(current_user.id, text)
    end
  end
end
