class Source < ActiveRecord::Base
  belongs_to :user
  has_many :feed_entries

  validates :feed_url, uniqueness: {scope: :user_id, message: "Already Exists." }
end
