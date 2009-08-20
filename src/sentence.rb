require 'tree'

class Sentence
  attr_accessor :english, :korean, :tree, :document
  
  def initialize(kor, eng, tree, document=nil)
    @english=eng
    @korean=kor
    @tree=tree
    @document=document
    @pattern = []
    @tree.each_leaf() do |node|
      @pattern<<node.parent.content unless node.parent == nil
    end
  end
  
  def pattern
    @pattern.join('_')
  end
   
end