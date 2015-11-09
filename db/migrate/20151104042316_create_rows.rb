class CreateRows < ActiveRecord::Migration
  def change
    create_table :rows do |t|
      t.string :name
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
