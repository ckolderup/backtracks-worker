require_relative 'models/fetch'
require 'haml'

module Scrobble
  def self.chart_v1(username)
    fetch = Fetch.new

    years = (1..3).map do |y|
      (artists, albums, tracks) = fetch.get_charts(:user => username,
                          :years_ago => y,
                          :chart_size => 15)

      {
        num: y,
        plural: (y == 1)? "" : "s",
        album_rows: albums.each_slice(5).map { |row| { albums: row } }
      }
    end

    template = File.read('views/email.haml')
    Haml::Engine.new(template).render(Object.new, years: years)
  end
end

