class Album
  attr_reader :title
  attr_reader :artist
  attr_reader :cover
  attr_reader :url

  def initialize(param = {})
    param[:cover] ||= "http://placekitten.com/174/174"
    @title = param[:title]
    @cover = param[:cover]
    @artist = param[:artist]
    @url = param[:url]
  end
end

