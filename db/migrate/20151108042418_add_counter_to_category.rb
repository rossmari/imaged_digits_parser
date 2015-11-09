class AddCounterToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :rows_count, :integer
  end
end
