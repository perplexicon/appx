class DashboardsController < ApplicationController
  def show
    @feed_entries = current_user.timeline
  end
end
