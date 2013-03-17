class Track
  @title = nil
  @artist = nil
  @cover = nil

  def initialize(param = {})
    @title = param[:title]
    @artist = param[:artist]
  end
end

