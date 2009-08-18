#!/usr/bin/env ruby
require 'rubygems'
require 'sqlite3'
require 'ftools'

file = '../db/test.db'
File.delete(file) if File.file? file

db = SQLite3::Database.new("../db/test.db")
db.execute("CREATE TABLE leaf(tag VARCHAR(256), count INT, PRIMARY KEY(tag))")
db.close