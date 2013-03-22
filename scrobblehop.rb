require 'sinatra'
require 'sinatra/mustache'

require_relative 'models/artist'
require_relative 'models/album'
require_relative 'models/track'
require_relative 'models/fetch'
require_relative 'mailer'

get '/view' do
  chart_v1
end


get '/send' do
  send_email("ckolderup@gmail.com", "Weekly Album Charts", chart_v1)
  "OK"
end

def chart_v1
  fetch = Fetch.new

  @years = (1..3).map do |y|
    (artists, albums, tracks) = fetch.get_charts(:user => "caseyk",
                        :years_ago => y,
                        :chart_size => 15)

    {
      num: y,
      plural: (y == 1)? "" : "s",
      album_rows: albums.each_slice(5).map { |row| { albums: row } }
    }
  end

  mustache(:email)
end
