#!/usr/bin/env ruby
require 'rubygems'
require 'solr'
require 'tree_bank'
require 'sentence'

def usage(message = nil)
  puts message if message
  puts "ruby #{File.basename(__FILE__)} <file name>"
  exit(1)
end

$file_name = ARGV[0]
arr = []
total_count = 0

f = File.new($file_name)
while not f.eof?
  arr << Marshal.load(f)
end
f.close
conn = Solr::Connection.new('http://localhost:8983/solr', :autocommit => :off)
arr.each do |stc|
  conn.add(:english => stc.english,
            :korean =>stc.korean,
            :patterns => stc.patterns.join(" "))
  total_count+=1
end

puts "TotalCounts: #{total_count}"