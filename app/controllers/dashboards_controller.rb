class DashboardsController < ApplicationController
  def show
    if current_user.sources.any?
      @feed_entries = current_user.content_feed
    else
      @feed_entries = "no_sources"
    end
    @source = Source.new
  end
end
