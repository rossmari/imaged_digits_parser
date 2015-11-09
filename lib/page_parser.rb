require 'custom_exceptions'

class PageParser

  COLUMNS_ROW = 1

  attr_reader :document, :content, :rows, :headers, :row_parser

  def initialize(content)
    @content = content
    @document = Nokogiri::HTML(content)
    load_rows
    load_headers
    @row_parser = RowParser.new(load_imaged_digits())
  end

  # == return Array of RowWrapper-s
  def parse
    parsed_rows = []
    @rows.each do |row|
      next unless card_description_row?(row)

      parsed_rows << RowWrapper.new(row_parser.parse(row))
    end
    return parsed_rows
  end

  private

  def card_description_row?(row)
    row.attributes['class'].to_s =~ /deckdbbody/
  end

  # == return rows as Nokogiri::Xml::Elements
  def load_rows
    @rows = document.xpath('//td[@id="search_table_wrapper"]//tr')
    raise(PageParserNoRowException.new()) if rows.size.zero?
  end

  # == return columns headers Array of String
  def load_headers
    @headers = @rows[COLUMNS_ROW].xpath('td').map(&:text).pop
  end

  def load_imaged_digits
    image_digits_parser = ImageRecognition::StylesToDigitsParser.new(document)
    image_digits_parser.styles_to_digits
  end

end