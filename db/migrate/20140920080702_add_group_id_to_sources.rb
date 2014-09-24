class AddGroupIdToSources < ActiveRecord::Migration
  def change
    add_column :sources, :group_id, :integer, index: true
  end
end
