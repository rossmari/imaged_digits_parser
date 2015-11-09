class RowContent < ActiveRecord::Base

  belongs_to :row

  FIELDS = %w(mana type pt rarity condition stock price)

  FIELDS.each do |field|
    define_method(field.to_s) do
      value_from_content(field)
    end
  end

  def value_from_content(key)
    JSON.parse(content)[key]
  end

end
