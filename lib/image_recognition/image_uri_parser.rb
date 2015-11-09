class ImageRecognition::ImageUriParser < ImageRecognition::StyleParser

  URI_REGEXP = /image:url\(\/\/(\S*)\);}/

  def self.parse(document)
    style_string = parse_style_block(document)
    result = URI_REGEXP.match(style_string)
    return result[1]
  end

end