require 'lastfm'
require 'pp'
require 'andand'

class Artist
  @name = nil
  @img = nil

  def initialize(param = {})
    @name = param[:name]
    @img = param[:img]
  end
end

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

class Track
  @title = nil
  @artist = nil
  @cover = nil

  def initialize(param = {})
    @title = param[:title]
    @cover = param[:cover]
    @artist = param[:artist]
  end
end

class Fetch
  @lastfm = nil

  def initialize
    @lastfm = Lastfm.new(ENV['LASTFM_KEY'], ENV['LASTFM_SECRET'])
  end

  def fetch_chart(param = {})
    method = param[:method]
    user = param[:user]
    from = param[:from]
    to = param[:to]
    chart_size = param[:chart_size]
    format = param[:format]

    #TODO: validate

    response = @lastfm.user.send(method, :user => user, :from => from, :to => to).andand.take(chart_size)
    response.andand.map { |item| send(format, item) }
  end

  def new_artist(artist)
    Artist.new(:name => artist['name'])
  end

  def new_album(album)
    Album.new(:title => album['name'],
              :artist => album['artist']['content'])
  end

  def new_track(track)
    Track.new(:title => track['name'],
              :artist => track['artist']['content'])
  end

  def get_charts(years_ago, chart_size)
    last_year = Time.now - (years_ago * 365 * 24 * 60 * 60)
    chart = @lastfm.user.get_weekly_chart_list(:user => "caseyk").select { |c|
      c['from'].to_i <= last_year.to_i && c['to'].to_i >= last_year.to_i
    }.first

    artists = fetch_chart(:method => "get_weekly_artist_chart",
                          :user => "caseyk",
                          :from => chart['from'], :to => chart['to'],
                          :chart_size => 10,
                          :format => "new_artist")

    albums = fetch_chart(:method => "get_weekly_album_chart",
                          :user => "caseyk",
                          :from => chart['from'], :to => chart['to'],
                          :chart_size => 10,
                          :format => "new_album")

    tracks = fetch_chart(:method => "get_weekly_track_chart",
                          :user => "caseyk",
                          :from => chart['from'], :to => chart['to'],
                          :chart_size => 10,
                          :format => "new_track")

    [artists, albums, tracks]
  end
end

fetch = Fetch.new
(1..3).each {|y|
  puts "#{y} year#{y > 1 ? "s" : ""} ago:"
  pp fetch.get_charts(y, 10)
}

