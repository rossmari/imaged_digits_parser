class ImageRecognition::PositionParser < ImageRecognition::StyleParser

  WIDTH_REGEXP = /\.(\S+)\{background-position:(\S+)px (\S+)px;width:(\d)px;}/
  STANDARD_REGEXP = /\.(\w+?)\{background-position:([-,0-9]+)px\s([-,0-9]+)px;}/

  class << self
    def parse(document, regexp)
      style_string = parse_style_block(document)
      digits = style_string.scan(regexp).map{|match| {name: match[0], x: match[1].to_i, y: match[2].to_i}}
      return digits
    end

    def parse_standard(document)
      parse(document, STANDARD_REGEXP)
    end

    def parse_dots(document)
      parse(document, WIDTH_REGEXP)
    end
  end

end