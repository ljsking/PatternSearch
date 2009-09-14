require 'rubygems'
require 'tagger'
require 'tree_bank'
require 'solr'

class Search
  def initialize
    @tagger = Tagger.new
    @conn = Solr::Connection.new('http://localhost:8983/solr')
  end
  def get_verbs(english, pattern)
    words = english.split(" ")
    pattern = pattern.split("_")
    
    index = 0
    verbs = []
    verb_forms = ['VB', 'VBD', 'VBG', 'VBN', 'VBP', 'VBZ']
    pattern.each do |symbol|
      verbs<<words[index] if verb_forms.include?(symbol)
      index+=1
    end
    return verbs
  end
  def search(english)
    english = @tagger.split(english)[0]
    treebank = TreeBank.new(@tagger.tag(english))
    patterns = (treebank.make_patterns.sort {|a,b| a[1]<=>b[1]} ).reverse

    pattern = patterns[0][0]
    verbs = get_verbs(english, pattern)
    
    return @conn.query(make_query(patterns, verbs)).hits
  end
  def change_alphabet(str)
    rz=str.gsub(/—/) do |word|
      word = '-'
    end
    return rz
  end
  def escape(str)
    need_escaped = ['+', '-', '&&', '||', '!', '(', ')', '{', '}', '[', ']', '^', '"', '~', '*', '?', ':', '\\']
    rz=str.gsub(/:/) do |word|
      word = '\\'+word
    end
    return rz
  end
  def make_query(patterns, verbs)
    qeuries=[]
    patterns.each do |item|
      pattern=item[0]
      point=item[1]
      pattern = change_alphabet pattern
      pattern = escape pattern
      qeuries<<"(patterns:#{pattern})^#{point}" if point>0.1
    end

    verbs.each do |verb|
      qeuries<<"verbs:#{verb}"
    end
    return qeuries.join(" ")
  end
end