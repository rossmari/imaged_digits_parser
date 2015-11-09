class RowParser

  IMAGED_CELLS = [7,8]

  attr_reader :imaged_digits, :digits_classes

  def initialize(digits)
    @imaged_digits = digits
    @digits_classes = imaged_digits.keys
  end

  def parse(row)
    cells = row.xpath('td')
    cell_values = []
    cells.each_with_index do |cell, index|
      if IMAGED_CELLS.include?(index) && cell.xpath('div').any?
        cell_values << parse_imaged_cell(cell)
      else
        cell_values << parse_cell(cell)
      end
    end
    return cell_values
  end

  def parse_imaged_cell(cell)
    digit = ''
    extract_divs(cell).each do |div|
      classes = div.attributes['class'].to_s.split
      classes.each do |css_class|
        next unless digits_classes.include?(css_class)
        digit << imaged_digits[css_class].to_s
      end
    end
    return digit.to_f
  end

  def extract_divs(content)
    divs = content.xpath('div')
    if divs.any?
      extract_divs(divs)
    else
      return content
    end
  end

  def parse_cell(cell)
    cell.content.gsub("\n", '')
  end

end

