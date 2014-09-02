class FeedEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :source

  def self.update_from_feed(user, source)
    feed = Feedjira::Feed.fetch_and_parse(source.feed_url)
    feed.entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          :name => entry.title,
          :content => entry.content,
          :url => entry.url,
          :published_at => entry.published,
          :guid => entry.id,
          :source_id => source.id,
          :user_id => user.id
        )
      end
    end
  end
end
