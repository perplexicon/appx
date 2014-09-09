class Source < ActiveRecord::Base
  belongs_to :user
  has_many :feed_entries
end
