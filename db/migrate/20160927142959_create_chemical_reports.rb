class CreateChemicalReports < ActiveRecord::Migration
  def change
    create_table :chemical_reports do |t|
      t.string :file
      t.integer :separation_result_id
      t.timestamps null: false
    end
  end
end
