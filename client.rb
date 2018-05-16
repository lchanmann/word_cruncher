#!/usr/bin/env ruby -I lib

require 'word_cruncher'
require 'strategy'

strategy = Strategy::File.new
sequences_file = strategy.create 'sequences'
words_file = strategy.create 'words'
dict = File.new 'dictionary.txt'

client = WordCruncher.new sequences_file, words_file
client.process dict

# close files
sequences_file.close
words_file.close

# display
puts "Done!"
puts "Files generated:"
puts "-- #{sequences_file.path}"
puts "-- #{words_file.path}"
