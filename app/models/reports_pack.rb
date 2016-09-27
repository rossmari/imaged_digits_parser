class ReportsPack < ActiveRecord::Base

  enum status: {not_processed: 0, success: 1, fail: 2}

  has_many :chemical_reports
  accepts_nested_attributes_for :chemical_reports

end
