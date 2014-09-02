class DashboardsController < ApplicationController
  def show
    @feed_entries = current_user.content_feed
  end
end
