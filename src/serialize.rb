#!/usr/bin/env ruby
require 'rubygems'
require 'tree_bank'
require 'ptxt_parser'
require 'logger'

$LOG = Logger.new('log_file.log', 'monthly') 

def usage(message = nil)
  puts message if message
  puts "ruby #{File.basename(__FILE__)} <data dir>"
  exit(1)
end

usage() if ARGV.size != 1
$data_dir = ARGV[0]

files = []
if File.directory?($data_dir)
  files = Dir["#$data_dir/**/*.ptxt"]
elsif File.file?($data_dir)
  files << $data_dir
else
  usage("Directory '#{$data_dir}' doesn't exist.")
end

begin
  FileUtils.mkdir_p('../dump/')
rescue
  usage("Can't create index directory '../dump/'.")
end

parser = PTxt_Parser.new

files.each do |file_name|
  puts file_name
  models, count = parser.parse(file_name)
  path, fname = File.split(file_name)
  name = File.basename(path)+'_'+fname
  File.open("../dump/#{name}.dump", 'w') do |f|
    models.sentences.each do |sentence|
      Marshal.dump(sentence, f)
    end
  end
  puts "end with #{count}"
end

