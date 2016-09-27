class AddStatusToReportsPack < ActiveRecord::Migration
  def change
    add_column :reports_packs, :status, :integer, default: 0, null: false
  end
end
