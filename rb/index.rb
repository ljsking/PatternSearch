#!/usr/bin/env ruby
require 'rubygems'
require 'ferret'
require 'fileutils'
include Ferret
include Ferret::Index

def usage(message = nil)
  puts message if message
  puts "ruby #{File.basename(__FILE__)} <data dir> <index dir>"
  exit(1)
end

usage() if ARGV.size != 2
usage("Directory '#{ARGV[0]}' doesn't exist.") unless File.directory?(ARGV[0])

$data_dir, $index_dir = ARGV

begin
  FileUtils.mkdir_p($index_dir)
rescue
  usage("Can't create index directory '#$index_dir'.")
end

index = Index.new(:path => $index_dir,
                  :create => true)

Dir["#$data_dir/**/*.ptxt"].each do |file_name|
  index << {:file_name => file_name, :content => File.read(file_name)}
end
index.optimize()
index.close()