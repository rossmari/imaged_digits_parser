class ChangeConnectionFieldName < ActiveRecord::Migration
  def change
    rename_column :chemical_reports, :separation_result_id, :reports_pack_id
  end
end
