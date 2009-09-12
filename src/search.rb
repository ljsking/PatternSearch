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
    rz=@tagger.split(english)
    english = rz[0]
    
    treebank = TreeBank.new(@tagger.tag(english))
    patterns = treebank.make_patterns
    sorted = (patterns.sort {|a,b| a[1]<=>b[1]} ).reverse

    pattern = sorted[0][0]
    verbs = get_verbs(english, pattern)
    
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
    return @conn.query(qeuries.join(" ")).hits
  end
end