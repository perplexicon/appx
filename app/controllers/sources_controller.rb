class SourcesController < ApplicationController
  def index
    @sources = Source.all
  end

  def create
    feed_url = source_params[:feed_url]
    source = Source.update_list(current_user, feed_url)
    FeedEntry.add_feed(current_user, source)
    redirect_to dashboard_path
  end

  def show
    @source = Source.find(params[:id])
  end

  private

  def source_params
    params.require(:source).permit(:feed_url)
  end
end
