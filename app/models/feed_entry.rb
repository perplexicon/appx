class FeedEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :source

  def self.add_feed(user, source)
    @user = user
    @source = source
    feed = fetch_parse(@source)
    add_entries(feed.entries)
  end

  def self.update_feed(user, sources)
    @user = user
    sources.each do |source|
      @source = source
      feed = fetch_parse(@source)
      updated_feed = Feedjira::Feed.update(feed)
      if updated_feed.updated?
        add_entries(feed.new_entries)
      end
    end
  end

  private

  def self.fetch_parse(source)
    Feedjira::Feed.fetch_and_parse(source.feed_url)
  end

  def self.add_entries(entries)
    entries.each do |entry|
      unless exists? guid: entry.id
        create!(
          name: entry.title,
          content: entry.content || entry.summary,
          url: entry.url,
          published_at: entry.published,
          guid: entry.id,
          source_id: @source.id,
          user_id: @user.id
        )
      end
    end
  end
end
