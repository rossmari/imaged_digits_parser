StyleDigitProvider = Struct.new(:name, :value)
ImageDigitFragment = Struct.new(:name, :image)

class ImageRecognition::NamedFragmentsCropper

  attr_reader :document

  # todo : fix ImageRecognition::ImageLoader saving image - place it into ram
  def initialize(document)
    @document = document

    image_uri = ImageRecognition::ImageUriParser.parse(document)
    ImageRecognition::ImageLoader.save_image(image_uri)
  end

  def crop_fragments
    standard_positions = ImageRecognition::PositionParser.parse_standard(document)
    dots_positions = ImageRecognition::PositionParser.parse_dots(document)

    cropper = ImageRecognition::FragmentsCropper.new(ImageRecognition::ImageLoader::FILE_NAME)

    fragments = []
    standard_positions.each do |p|
      image = cropper.crop(p[:x], p[:y])
      fragments << ImageDigitFragment.new(p[:name], image)
    end

    dots_positions.each do |p|
      image = cropper.crop(p[:x], p[:y], 3, 14)
      fragments << ImageDigitFragment.new(p[:name], image)
    end

    return fragments
  end

end