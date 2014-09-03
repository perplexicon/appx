class User < ActiveRecord::Base
  has_many :feed_entries
  has_many :sources

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def content_feed
    FeedEntry.update_feed(self, self.sources)
    FeedEntry.where(user_id: id).order(published_at: :desc).limit(10)
  end
end
