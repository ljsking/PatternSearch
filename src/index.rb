#!/usr/bin/env ruby
require 'rubygems'
require 'ferret'
require 'fileutils'
require 'ptxt_parser'
require 'tagger'
include Ferret
include Ferret::Index

def usage(message = nil)
  puts message if message
  puts "ruby #{File.basename(__FILE__)} <data dir> <index dir>"
  exit(1)
end

usage() if ARGV.size != 2
$data_dir, $index_dir = ARGV

files = []
if File.directory?(ARGV[0])
  files = Dir["#$data_dir/**/*.ptxt"]
elsif File.file?(ARGV[0])
  files << ARGV[0]
else
  usage("Directory '#{ARGV[0]}' doesn't exist.")
end

begin
  FileUtils.mkdir_p($index_dir)
rescue
  usage("Can't create index directory '#$index_dir'.")
end

field_infos=Index::FieldInfos.load(File.read("../ferret.yml"))
index = Index.new(:path => $index_dir,
                  :create => true,
                  :field_infos=>field_infos)

parser = PTxt_Parser.new
total_count = 0

files.each do |file_name|
  puts file_name
  models, count = parser.parse(file_name)
  total_count+=count
  models.sentences.each do |sentence|
    doc = Document.new
    doc[:english]=sentence.english
    doc[:korean]=sentence.korean
    doc[:pattern]=sentence.pattern
    index<<doc
  end
  #index << {:file_name => file_name, :content => File.read(file_name)}
end
index.optimize()
index.close()
puts "TotalCounts: #{total_count}"