class Artist
  attr_reader :name
  attr_reader :url

  def initialize(param = {})
    @name = param[:name]
    @url = param[:url]
  end
end
