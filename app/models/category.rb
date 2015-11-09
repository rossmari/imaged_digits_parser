class Category < ActiveRecord::Base

  has_many :rows
  has_many :updates_logs

  validates :value, uniqueness: true

end
