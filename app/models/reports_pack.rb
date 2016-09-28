class ReportsPack < ActiveRecord::Base

  enum status: {not_processed: 0, success: 1, fail: 2}

  has_many :chemical_reports
  accepts_nested_attributes_for :chemical_reports

  def separate_reports
    chemical_reports.each do |report|
      separator = ChemicalSeparator.new(report.file.url)
      separator.separate
      report.update(log: separator.log.join(';'))
    end
    self.success!
  end

end
