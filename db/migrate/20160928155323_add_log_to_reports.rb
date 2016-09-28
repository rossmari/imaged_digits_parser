class AddLogToReports < ActiveRecord::Migration
  def change
    add_column :chemical_reports, :log, :text
  end
end
