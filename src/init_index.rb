require 'rubygems'
require 'ferret'
require 'fileutils'

include Ferret
include Ferret::Index

dir = '../index'
FileUtils.rm_rf 'dir'

field_infos=Index::FieldInfos.load(File.read("../ferret.yml"))
index = Index.new(:path => "../index",
                  :create => true,
                  :field_infos=>field_infos)
index.close()