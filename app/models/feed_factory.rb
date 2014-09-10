class FeedFactory
  def initialize(user, feed_url)
    @user = user
    feed = fetch_parse(feed_url)
    source = find_or_create_source(feed)

    add_feed_entries(source, feed.entries)
  end

  private

  def fetch_parse(feed_url)
    Feedjira::Feed.fetch_and_parse(feed_url)
  end

  def find_or_create_source(feed)
    @user.sources.
      create_with(source_params(feed)).
      find_or_create_by!(name: feed.title)
  end

  def add_feed_entries(source, entries)
    entries.each do |entry|
      @user.feed_entries.
        create_with(feed_params(source, entry)).
        find_or_create_by!(guid: entry.id)
    end
  end

  def source_params(feed)
    {
      etag: feed.etag,
      url: feed.url,
      feed_url: feed.feed_url,
      last_modified: feed.last_modified
    } 
  end

  def feed_params(source, entry)
    {
      name: entry.title,
      content: entry.content || entry.summary,
      url: entry.url,
      published_at: entry.published,
      source_id: source.id,
    }
  end
end
