require 'net/http'

class PageGrabber

  class << self

    def grab(category, move)
      uri = generate_uri(category, move)
      response = Net::HTTP.get_response(uri)
      if response.is_a?(Net::HTTPSuccess)
        return response.body
      else
        return nil
      end
    end

    private

    def generate_uri(category, move)
      URI("#{resource_url}/category.php?cat=#{category}&start=#{move}")
    end

    def resource_url
      ENV['resource_url']
    end

  end

end