class Album
  @title = nil
  @artist = nil
  @cover = nil

  def initialize(param = {})
    @title = param[:title]
    @cover = param[:cover]
    @artist = param[:artist]
  end
end

