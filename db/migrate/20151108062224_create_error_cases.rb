class CreateErrorCases < ActiveRecord::Migration
  def change
    create_table :error_cases do |t|
      t.string :text
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
