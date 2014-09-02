class Source < ActiveRecord::Base
  belongs_to :user
  has_many :feed_entries

  def self.update_from_feed(user, feed_url)
    feed = Feedjira::Feed.fetch_and_parse(feed_url)
    unless exists? :etag => feed.etag
      create!(
        :etag => feed.etag,
        :name => feed.title,
        :url => feed.url,
        :feed_url => feed_url,
        :user_id => user
      )
    end
  end
end
