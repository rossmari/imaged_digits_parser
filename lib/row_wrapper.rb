class RowWrapper

  # todo : move to config

  # category is merged next as Category class
  ROW_HEADERS = {name: 0}
  ROW_CONTENT_HEADERS = {mana: 2, type: 3, pt: 4,	rarity: 5, condition: 6, stock: 7, price: 8}

  attr_reader :content

  def initialize(content)
    @content = content
  end

  def row_data
    @row_data ||= data_by_headers(ROW_HEADERS)
  end

  def content_data
    @content_data ||= data_by_headers(ROW_CONTENT_HEADERS)
  end

  def new_row?
    !content[ROW_HEADERS[:name]].sub(/\u00a0/, '').empty?
  end

  private

  def data_by_headers(headers)
    result = {}
    headers.each do |header, position|
      result[header] = content[position]
    end
    return result
  end

end