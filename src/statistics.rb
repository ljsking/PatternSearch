#!/usr/bin/env ruby
require 'rubygems'
require 'ftools'
require 'sentence'
require 'logger'
require 'sqlite3'

$LOG = Logger.new('log_file.log', 'monthly') 

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

table = {}
tags = {}
arr.each do |stc|
  pttn = stc.pattern
  val = table[pttn]
  val = 0 if val == nil
  val += 1
  table[pttn] = val
  stc.pattern.each do |p|
    val = tags[p]
    val = 0 if val == nil
    val += 1
    tags[p] = val
  end
end

db = SQLite3::Database.new("../db/test.db")

table.each do |key, value|
  rows = db.execute("SELECT * FROM patterns WHERE pattern='#{key}'")
  if rows.size == 0
    db.execute("INSERT INTO patterns (pattern, count) VALUES ('#{key}', #{value})")
  elsif rows.size == 1
    db.execute("UPDATE patterns SET count=#{rows[0][1].to_i+value} WHERE pattern='#{key}'")
  else
    puts "Exception: #{key} has many rows"
  end
end

#tags.each do |key, value|
#  rows = db.execute("SELECT * FROM tags WHERE tag='#{key}'")
#  if rows.size == 0
#    db.execute("INSERT INTO tags (tag, count) VALUES ('#{key}', #{value})")
#  elsif rows.size == 1
#    db.execute("UPDATE tags SET count=#{rows[0][1].to_i+value} WHERE tag='#{key}'")
#  else
#    puts "Exception: #{key} has many rows"
#  end
#end