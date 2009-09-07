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

def add_index(conn, stc)
  verbs = stc.verbs.join(" ")
  patterns = stc.patterns.join(" ")
  begin
    conn.add(:english => stc.english,
             :korean =>stc.korean,
             :verbs => verbs,
             :patterns => patterns)
  rescue Timeout::Error => e
    puts "Exception: index timeout error with #{e}"
    add_index(conn, stc)
  end
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
  #puts "#{stc.english} has verbs: #{stc.verbs.join(" ")}"
  add_index(conn, stc)
  total_count+=1
end

puts "TotalCounts: #{total_count}"