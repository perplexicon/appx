class FeedEntry < ActiveRecord::Base
  belongs_to :user

  def self.update_from_feed(user, feed_url)
    feed = Feedjira::Feed.fetch_and_parse(feed_url)
    feed.entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          :name => entry.title,
          :content => entry.content,
          :url => entry.url,
          :published_at => entry.published,
          :guid => entry.id,
          :feed_name => feed.title,
          :feed_url => feed.url,
          :user_id => user
        )
      end
    end
  end
end
