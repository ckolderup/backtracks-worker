require 'sinatra'

require_relative 'models/artist'
require_relative 'models/album'
require_relative 'models/track'
require_relative 'models/fetch'
require_relative 'mailer'
require_relative 'scrobble'

get '/view' do
  Scrobble.chart_v1(params[:username], 4)
end

get '/send' do
  @address = params[:email]
  @subject = params[:subject] || "Backtracks: Web-Invoked Test Email"
  @username = params[:username]
  Mailer.send_email(@address, @subject, Scrobble.chart_v1(@username))
  "OK"
end

