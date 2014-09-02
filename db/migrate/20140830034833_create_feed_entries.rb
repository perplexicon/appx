class CreateFeedEntries < ActiveRecord::Migration
  def change
    create_table :feed_entries do |t|
      t.string :name
      t.text :content, null: false
      t.string :url, null: false
      t.datetime :published_at, null: false
      t.string :guid, null: false
      t.string :feed_name, null: false, index: true
      t.string :feed_url, null: false
      t.references :user, null: false, index: true

      t.timestamps
    end
  end
end
