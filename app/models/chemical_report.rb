class ChemicalReport < ActiveRecord::Base
  mount_uploader :file, ChemicalReportUploader

  belongs_to :reports_pack

end
