class ImageRecognition::StylesToDigitsParser

  attr_reader :fragments

  def initialize(document)
    cropper = ImageRecognition::NamedFragmentsCropper.new(document)
    @fragments = cropper.crop_fragments
  end

  def styles_to_digits
    digits_parser = ImageRecognition::ImageToDigitParser.new

    styles_as_digits = {}
    fragments.each do |fr|
      style = fr[:name]
      digit = digits_parser.parse(fr[:image])

      styles_as_digits[style] = digit
    end
    return styles_as_digits
  end

end