require 'sinatra'
require_relative 'scrobble'
require_relative 'mailer'

task :environment do
    Sinatra::Application.environment = ENV['RACK_ENV']
end

Dir.glob('lib/tasks/*.rake').each { |r| import r }
