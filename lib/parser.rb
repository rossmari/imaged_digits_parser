require 'custom_exceptions'

class Parser

  class << self

    def parse(category)

      pages = 20
      pages.times do |i|
        content = PageGrabber.grab(category.value, i * 50)

        row_wrappers = PageParser.new(content).parse

        rows = []
        row_wrappers.each do |wrapper|
          if wrapper.new_row?
            rows << Row.create(wrapper.row_data.merge!({category: category}))
          end
          rows.last.row_contents << RowContent.create(content: wrapper.content_data.to_json)
        end
        puts "#{rows.count} parsed from page #{i}"
      end
    rescue PageParserNoRowException
      return true
    rescue StandardError => exception
      ErrorCase.create(text: exception.message)
      return false
    end
  end

end
