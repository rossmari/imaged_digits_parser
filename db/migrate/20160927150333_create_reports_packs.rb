class CreateReportsPacks < ActiveRecord::Migration
  def change
    create_table :reports_packs do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
