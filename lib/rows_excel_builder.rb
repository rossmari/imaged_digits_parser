class RowsExcelBuilder

  class << self

    def generate_xlsx(category_id)
      package = Axlsx::Package.new
      wb = package.workbook
      ws = wb.add_worksheet name: 'First page'

      header_style = wb.styles.add_style(b: true, sz: 14, alignment: { horizontal: :center})

      ws.add_row(['Name', 'Category'] + RowContent::FIELDS.map(&:capitalize), style: header_style)

      Row.where(category: category_id).find_each do |row|

        first_row = [ row.name , row.category.name ]
        ws.add_row(first_row + content_as_array(row.row_contents.first))

        row.row_contents[1..row.row_contents.count].each do |content|
          ws.add_row(['', ''] + content_as_array(content))
        end

      end
      package
    end

    private

    def content_as_array(content)
      result = []
      RowContent::FIELDS.each do |field|
        result << content.send(field)
      end
      return result
    end

  end
end


