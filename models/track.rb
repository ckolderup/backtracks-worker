class Track
  attr_reader :title
  attr_reader :artist
  attr_reader :url

  def initialize(param = {})
    @title = param[:title]
    if @title.length > 31 then
      @title = @title[0...28] + '...'
    end
    @artist = param[:artist]
    @url = param[:url]
  end
end

