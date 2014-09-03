class Source < ActiveRecord::Base
  belongs_to :user
  has_many :feed_entries

  def self.update_list(user, feed_url)
    feed = Feedjira::Feed.fetch_and_parse(feed_url)
    unless exists? etag: feed.etag
      create!(
        etag: feed.etag,
        name: feed.title,
        url: feed.url,
        feed_url: feed_url,
        last_modified: feed.last_modified,
        user_id: user.id
      )
    end
  end
end
