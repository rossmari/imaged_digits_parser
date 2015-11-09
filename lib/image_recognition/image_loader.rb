require 'open-uri'

class ImageRecognition::ImageLoader

  FILE_NAME = Rails.root.join('public/template_file.png')

  def self.save_image(uri)
    File.open(FILE_NAME, 'wb') do |fo|
      fo.write open("http://#{uri}").read
    end
  end

end
