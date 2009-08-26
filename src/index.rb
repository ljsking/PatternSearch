#!/usr/bin/env ruby
require 'rubygems'
require 'ferret'
require 'fileutils'
require 'sentence'
include Ferret
include Ferret::Index

def usage(message = nil)
  puts message if message
  puts "ruby #{File.basename(__FILE__)} <file name>"
  exit(1)
end

$file_name = ARGV[0]

f = File.new($file_name)
arr = []
while not f.eof?
  arr << Marshal.load(f)
end
f.close

field_infos=Index::FieldInfos.load(File.read("../ferret.yml"))
index = Index.new(:path => "../index",
                  :create => false,
                  :field_infos=>field_infos)

total_count = 0

arr.each do |stc|
  total_count+=arr.size
  doc = Document.new
  doc[:english]=stc.english
  doc[:korean]=stc.korean
  doc[:patterns]=Field.new(stc.patterns)
  index<<doc
end
index.optimize()
index.close()
puts "TotalCounts: #{total_count}"