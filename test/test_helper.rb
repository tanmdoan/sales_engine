gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'bigdecimal'
Dir["./lib/*.rb"].each { |file| require "#{file}" }
