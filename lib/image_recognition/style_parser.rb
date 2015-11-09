# todo : add exception handling
class ImageRecognition::StyleParser

  class << self
    private
    def parse_style_block(document)
      document.xpath('//style').first.content
    end
  end

end