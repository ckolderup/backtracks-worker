require 'pp'

require_relative 'models/artist'
require_relative 'models/album'
require_relative 'models/track'
require_relative 'models/fetch'

fetch = Fetch.new
(1..3).each {|y|
  puts "#{y} year#{y > 1 ? "s" : ""} ago:"

  pp fetch.get_charts(:user => "caseyk",
                      :years_ago => y,
                      :chart_size => 10)
}

