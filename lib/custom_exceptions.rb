class PageParserNoRowException < StandardError
  def initialize(msg = 'No rows found')
    super
  end
end