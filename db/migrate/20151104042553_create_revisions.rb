class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.timestamp :name

      t.timestamps null: false
    end
  end
end
