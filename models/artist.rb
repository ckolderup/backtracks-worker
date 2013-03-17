class Artist
  @name = nil

  def initialize(param = {})
    @name = param[:name]
  end
end
