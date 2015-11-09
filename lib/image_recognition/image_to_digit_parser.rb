class ImageRecognition::ImageToDigitParser

  PATH = Rails.root.join('public/digit_templates')

  attr_reader :templates

  def initialize
    @templates = []
    (0..9).each do |file|
      templates << {image: load_image("#{file}.png"), value: file}
      templates << {image: load_image("#{file}_2.png"), value: file}
    end
    templates << {image: load_image('dot.png'), value: '.'}
    templates << {image: load_image('dot_2.png'), value: '.'}
  end

  def parse(image)
    comparing_results = []
    templates.each do |template|
      next unless check_image_sizes(image, template[:image])
      comparing_results << { value: template[:value], weight: compare(image, template[:image]) }
    end
    return comparing_results.min_by{ |res| res[:weight] }[:value]
  end

    def compare(image, template)
      diff = 0
      (0..image.width - 1).each do |x|
        (0..image.height - 1).each do |y|
          diff += ChunkyPNG::Color.euclidean_distance_rgba(image[x,y], template[x,y])
        end
      end
      return diff
    end

  private

  def load_image(image_name)
    ChunkyPNG::Image.from_file(PATH.join(image_name))
  end

  def check_image_sizes(a, b)
    a.width == b.width && a.height == b.height
  end

end