#!/usr/bin/env ruby
require 'rubygems'
require 'ptxt_parser'

def usage(message = nil)
  puts message if message
  puts "ruby #{File.basename(__FILE__)} <data dir> <dest dir>"
  exit(1)
end

usage() if ARGV.size != 1
$data_dir = ARGV[0]

files = []
if File.directory?($data_dir)
  files = Dir["#$data_dir/**/*.ptxt"]
elsif File.file?($data_dir)
  files << ARGV[0]
else
  usage("Directory '#{$data_dir}' doesn't exist.")
end

parser = PTxt_Parser.new

files.each do |file_name|
  puts file_name
  models, count = parser.parse(file_name)
  total_count+=count
  File.open("../dump/#{file_name}.dump", 'w+') do |f|
    models.sentences.each do |sentence|
      Marshal.dump(sentence, f)
    end
  end
end

