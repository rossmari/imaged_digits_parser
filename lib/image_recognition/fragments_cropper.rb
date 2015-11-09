class ImageRecognition::FragmentsCropper

  attr_reader :image, :height, :width

  def initialize(file)
    @image = ChunkyPNG::Image.from_file(file)
  end

  def crop(x, y, width = 7, height = 14)
    xm = x <= 0 ? -x : image.width - x
    ym = y <= 0 ? -y : image.height - y

    image.crop(xm, ym, width, height)
  end

end