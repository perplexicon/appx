class FeedEntriesController < ApplicationController
  def destroy
    feed_entry = FeedEntry.find(params[:id])
    feed_entry.destroy
    redirect_to root_path
  end
end
