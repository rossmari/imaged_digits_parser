class AddRowsCountToUpdatesLog < ActiveRecord::Migration
  def change
    add_column :updates_logs, :rows_count, :integer, default: 0, null: false
  end
end
