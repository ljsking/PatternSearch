#!/usr/bin/env ruby
require 'rubygems'
require 'tagger'
require 'tree_bank'
require 'solr'
#It 's the most I can offer you .
print "Pattern search:"
@tagger = Tagger.new
@conn = Solr::Connection.new('http://localhost:8983/solr')
while english = gets
  start_time = Time.now
  
  rz=@tagger.split(english)
  english = rz[0]
  words = english.split(" ")
  treebank = TreeBank.new(@tagger.tag(english))
  patterns = treebank.make_patterns
  sorted = (patterns.sort {|a,b| a[1]<=>b[1]} ).reverse
  
  pattern = sorted[0][0].split("_")
  index = 0
  verbs = []
  verb_forms = ['VB', 'VBD', 'VBG', 'VBN', 'VBP', 'VBZ']
  pattern.each do |symbol|
    verbs<<words[index] if verb_forms.include?(symbol)
    index+=1
  end
  
  qeuries=[]
  puts "Searching #{sorted[0][0]}"
  sorted.each do |item|
    pattern=item[0]
    point=item[1]
    qeuries<<"(patterns:#{pattern})^#{point}" if point>0.1
  end
  
  verbs.each do |verb|
    qeuries<<"verbs:#{verb}"
  end
  
  puts "Searching time : #{Time.now-start_time} sec"
  
  response = @conn.query(qeuries.join(" "))
  puts "hits size: #{response.hits.size}"
  index=0
  response.hits.each do |hit|
    puts "[#{index}][#{hit['score']}]:#{hit['english']}"
    index+=1
  end
  print "Pattern search:"
end