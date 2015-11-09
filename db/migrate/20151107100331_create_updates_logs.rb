class CreateUpdatesLogs < ActiveRecord::Migration
  def change
    create_table :updates_logs do |t|
      t.integer :category_id
      t.integer :status
      t.timestamps null: false
    end
  end
end
