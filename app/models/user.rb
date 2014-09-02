class User < ActiveRecord::Base
  has_many :feed_entries

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def content_feed
    FeedEntry.where(user_id: id).order(created_at: :desc)
  end
end
