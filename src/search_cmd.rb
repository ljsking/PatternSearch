#!/usr/bin/env ruby
require 'search'
#It 's the most I can offer you .
print "Pattern search:"
@search = Search.new
while english = gets
  start_time = Time.now
  hits = @search.search(english)
  puts "Searching time : #{Time.now-start_time} sec"
  puts "hits size: #{hits.size}"
  index=0
  hits.each do |hit|
    puts "[#{index}][#{hit['score']}]:#{hit['english']}"
    index+=1
  end
  print "Pattern search:"
end