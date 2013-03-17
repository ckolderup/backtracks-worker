class Track
  attr_reader :title
  attr_reader :artist

  def initialize(param = {})
    @title = param[:title]
    @artist = param[:artist]
  end
end

