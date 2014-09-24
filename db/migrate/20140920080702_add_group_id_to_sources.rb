class AddGroupIdToSources < ActiveRecord::Migration
  def change
    add_column :sources, :group_id, :integer, default: 1, index: true
  end
end
