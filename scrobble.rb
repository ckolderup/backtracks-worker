require_relative 'models/fetch'
require 'haml'

module Scrobble
  @@CHART_SIZE = 6
  @@ROWS = 2

  def self.chart_v1(username, year_range=(1..3))
    fetch = Fetch.new

    years = year_range.map do |y|
      (artists, albums, tracks) = fetch.get_charts(:user => username,
                          :years_ago => y,
                          :chart_size => @@CHART_SIZE)

      {
        num: y,
        plural: (y == 1)? "" : "s",
        album_rows: albums.nil? ? [] : albums.each_slice(@@CHART_SIZE / @@ROWS).map { |row| { albums: row } },
        artists: artists,
        tracks: tracks
      }
    end

    raise Exception.new(true) if years.select { |y| !y[:album_rows].empty? }.empty?

    template = File.read('views/email.haml')
    Haml::Engine.new(template).render(Object.new, years: years)
  end
end

