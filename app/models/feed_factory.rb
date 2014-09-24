class FeedFactory
  attr_reader :new_source

  def initialize(user, feed_url)
    @user = user
    feed = fetch_parse(feed_url)
    source = find_or_create_source(feed)
    save_source(source)
    add_feed_entries(source, feed.entries)
  end

  private

  def fetch_parse(feed_url)
    Feedjira::Feed.fetch_and_parse(feed_url)
  end

  def find_or_create_source(feed)
    @user.sources.
      create_with(source_params(feed)).
      find_or_initialize_by(name: feed.title)
  end

  def save_source(source)
    @new_source = source.new_record?
    source.save
  end

  def add_feed_entries(source, entries)
    entries.each do |entry|
      if entry.published > source.updated_at || @new_source
        @user.feed_entries.
          create(feed_params(source, entry))
      end
    end
    source.update(last_modified: Time.now)
  end

  def source_params(feed)
    {
      name: feed.title,
      etag: feed.etag,
      url: feed.url,
      feed_url: feed.feed_url,
      last_modified: Time.now
    } 
  end

  def feed_params(source, entry)
    {
      name: entry.title,
      content: entry.content || entry.summary,
      url: entry.url,
      published_at: entry.published,
      source_id: source.id,
      guid: entry.id
    }
  end
end
