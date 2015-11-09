class UpdatesLog < ActiveRecord::Base

  enum status: [:process, :success, :failed]
  belongs_to :category

end
