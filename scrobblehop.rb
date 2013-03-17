require 'sinatra'

require_relative 'models/artist'
require_relative 'models/album'
require_relative 'models/track'
require_relative 'models/fetch'

get '/' do
  response = ""
  fetch = Fetch.new
  (1..3).each do |y|

    response << "<h2>#{y} Year#{y == 1 ? "": "s"} Ago</h2>\n\n"
    (artists, albums, tracks) = fetch.get_charts(:user => "caseyk",
                        :years_ago => y,
                        :chart_size => 15)

    albums.each_slice(5) do |row|
      row.each do |album|
        cover = album.cover
        cover ||= "http://placekitten.com/174/174"
        response << "<img src=\"#{cover}\">\n"
      end
      response << "<br>\n"
    end
  end

  response
end
