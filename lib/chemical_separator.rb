require 'rubyXL'

class ChemicalSeparator

  attr_reader :file_name, :document, :log

  def initialize(file_name)
    @file_name = file_name
    @document = RubyXL::Parser.parse(file_full_path)
    @log = []
  end

  def separate
    points = find_points
    points.each_with_index do |coordinates, index|
      move_points(coordinates[:start], coordinates[:stop], index + 1, coordinates[:sample_name])
    end
    document.write(file_full_path)
  end

  def move_points(start, stop, index, sample_name)
    new_worksheet = document.add_worksheet("New page #{index}")
    original_sheet = document.worksheets[0]

    new_worksheet.add_cell(0, 0, 'Wavelength, nm')
    new_worksheet.add_cell(0, 1, 'Abs')
    new_worksheet.add_cell(0, 2, 'Sample')
    new_worksheet.add_cell(1, 2, sample_name)
    new_worksheet.sheet_data[0][0].change_horizontal_alignment('center')
    new_worksheet.sheet_data[0][1].change_horizontal_alignment('center')
    new_worksheet.sheet_data[0][2].change_horizontal_alignment('center')
    new_worksheet.change_row_height(0, 15)
    new_worksheet.change_column_width(0, 15)

    new_sheet_row_index = 1
    (start..stop).each do |row_index|
      value0 = original_sheet[row_index][0].value
      value1 = original_sheet[row_index][1].value

      new_worksheet.add_cell(new_sheet_row_index, 0, value0)
      new_worksheet.add_cell(new_sheet_row_index, 1, value1)
      new_worksheet.change_row_height(new_sheet_row_index, 15)
      new_sheet_row_index += 1
    end
  end

  def find_points
    result = []
    sheet = document.worksheets[0]
    points_entry = nil
    row_index = 0
    last_row = sheet.count
    sample = nil
    sheet.each do |row|
      content = row ? row[0].value.to_s : ''
      if content == 'Sample:'
        sample = row[1].value.to_s
      end
      if content == 'Data Points' && points_entry.nil?
        points_entry ||= {}
        points_entry[:start] = row_index + 2
      end
      if (row.nil? || last_row == row_index) && points_entry
        points_entry[:stop] = row_index - 1
        points_entry[:sample_name] = sample
        result << points_entry
        log_points(points_entry)
        sample = nil
        points_entry = nil
      end
      row_index += 1
    end
    result
  end

  def log_points(entry)
    @log << "Start: #{entry[:start] + 1}, Stop: #{entry[:stop] + 1}, Count: #{entry[:stop] - entry[:start]}"
  end

  def file_full_path
    "#{Rails.root.join('public')}#{file_name}"
  end

end