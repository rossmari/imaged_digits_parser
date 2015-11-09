class CreateRowContents < ActiveRecord::Migration
  def change
    create_table :row_contents do |t|
      t.integer :row_id
      t.string :content
      t.timestamps null: false
    end
  end
end
