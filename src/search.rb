#!/usr/bin/env ruby
require 'rubygems'
require 'tagger'
require 'tree_bank'
require 'solr'

print "Pattern search:"
@tagger = Tagger.new
@conn = Solr::Connection.new('http://localhost:8983/solr')
while english = gets
  treebank = TreeBank.new(@tagger.tag(english))
  patterns = treebank.make_patterns
  sorted = (patterns.sort {|a,b| a[1]<=>b[1]} ).reverse
  qeuries=[]
  sorted.each do |item|
    pattern=item[0]
    point=item[1]
    qeuries<<"(patterns:#{pattern})^#{point}" if point>0.1
  end
  response = @conn.query(qeuries.join(" "))
  puts "hits size: #{response.hits.size}"
  puts "best[#{response.hits[0]['score']}]:#{response.hits[0]['english']}"
  print "Pattern search:"
end