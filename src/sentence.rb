require 'rubygems'
require 'tree'

class Sentence
  attr_accessor :english, :korean, :document
  def initialize(kor, eng, tree, document=nil)
    @english=eng
    @korean=kor
    @treebank=TreeBank.new(tree)
    @document=document
  end
  def patterns
    return @treebank.patterns
  end
  def make_pattern
    return @treebank.make_pattern
  end
end