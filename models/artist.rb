class Artist
  @name = nil
  @img = nil

  def initialize(param = {})
    @name = param[:name]
    @img = param[:img]
  end
end
