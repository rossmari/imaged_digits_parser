class Row < ActiveRecord::Base

  belongs_to :category, counter_cache: true
  has_many :row_contents, dependent: :destroy

end
