class Artist
  attr_reader :name

  def initialize(param = {})
    @name = param[:name]
  end
end
