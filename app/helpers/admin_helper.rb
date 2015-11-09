module AdminHelper

  def multi_row(row, param)
    content = ''
    row.row_contents.each_with_index do |row_content, index|
      css_class = 'multi-row-cell'
      css_class << ' first' if index.zero?
      css_class << ' last' if index == row.row_contents.size - 1

      param_value = row_content.send(param)
      if param_value.to_s.empty?
        css_class = 'multi-row-cell empty'
      end
      content << content_tag(:div, param_value, class: css_class)
    end

    raw(content)
  end

end