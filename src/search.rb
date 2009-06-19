#!/usr/bin/env ruby
require 'rubygems'
require 'ferret'
require 'fileutils'
include Ferret
include Ferret::Index

def usage(message = nil)
  puts message if message
  puts "ruby #{File.basename(__FILE__)} <index dir> <search phrase>"
  exit(1)
end 

usage() if ARGV.size != 2
usage("Index '#{ARGV[0]}' doesn't exist.") unless File.directory?(ARGV[0])

$index_dir, $search_phrase = ARGV

index = Index.new(:path => $index_dir)

results = []
total_hits = index.search_each($search_phrase) do |doc_id, score|
  results << "  #{score} - #{index[doc_id][:file_name]}"
end

puts "#{total_hits} matched your query:\n" + results.join("\n")

index.close()