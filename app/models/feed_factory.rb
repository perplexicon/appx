class FeedFactory
  def initialize(user, feed_url)
    feed = fetch_parse(feed_url)
    source = find_source(feed) || add_source(user, feed)

    add_feed_entries(source, feed.entries)
  end

  private

  def fetch_parse(feed_url)
    Feedjira::Feed.fetch_and_parse(feed_url)
  end

  def find_source(feed)
    Source.where(name: feed.title).first
  end

  def add_source(user, feed)
    Source.create!(
      etag: feed.etag,
      name: feed.title,
      url: feed.url,
      feed_url: feed.feed_url,
      last_modified: feed.last_modified,
      user_id: user.id
    )
  end

  def add_feed_entries(source, entries)
    entries.each do |entry|
      unless FeedEntry.where(guid: entry.id).exists?
        FeedEntry.create!(
          name: entry.title,
          content: entry.content || entry.summary,
          url: entry.url,
          published_at: entry.published,
          guid: entry.id,
          source_id: source.id,
          user_id: source.user.id
        )
      end
    end
  end
end
