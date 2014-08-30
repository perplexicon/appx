class DashboardsController < ApplicationController
  def show
    @feed_entries = current_user.content_feed
    @source = Source.new
  end
end
