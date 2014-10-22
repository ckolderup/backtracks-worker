require 'sinatra'
require_relative 'scrobble'
require_relative 'mailer'

task :environment do
    Sinatra::Application.environment = ENV['RACK_ENV']
end

Dir.glob('lib/tasks/*.rake').each { |r| import r }

desc "Send a single email"
task :send_single_email, [:email, :username, :subject] => [:environment] do |t, args|
  Mailer.send_email(args[:email], args[:subject], Scrobble.chart_v1(args[:username]))
end
