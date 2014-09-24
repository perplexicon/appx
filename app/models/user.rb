class User < ActiveRecord::Base
  has_many :feed_entries
  has_many :sources
  has_many :groups

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def content_feed
    update_user_feed
    show_user_feed
  end

  private

  def update_user_feed
    self.sources.each do |source|
      FeedFactory.new(self, source.feed_url)
    end
  end

  def show_user_feed
    FeedEntry.where(user_id: id).order(published_at: :desc).limit(20) || []
  end
end
