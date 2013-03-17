require 'rubygems'
require 'bundler'

Bundler.require

require './scrobblehop'
run Sinatra::Application
