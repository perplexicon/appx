class SourcesController < ApplicationController
  def index
    @sources = Source.all
  end

  def create
    add_feed
    redirect_to dashboard_path
  end

  def show
    @source = Source.find(params[:id])
  end

  private

  def add_feed
    FeedFactory.new(current_user, feed_url)
  end

  def feed_url
    source_params[:feed_url]
  end

  def source_params
    params.require(:source).permit(:feed_url)
  end
end
