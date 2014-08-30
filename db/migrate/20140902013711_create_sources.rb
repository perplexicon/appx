class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :etag, null: false
      t.string :name, null: false
      t.string :url, null: false
      t.string :feed_url, null: false
      t.time :last_modified, null: false
      t.references :user, null: false, index: true

      t.timestamps
    end
  end
end
