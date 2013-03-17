class Album
  attr_reader :title
  attr_reader :artist
  attr_reader :cover

  def initialize(param = {})
    @title = param[:title]
    @cover = param[:cover]
    @artist = param[:artist]
  end
end

