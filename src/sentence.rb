require 'tree'

class Sentence
  attr_accessor :english, :korean, :tree, :document
  
  def initialize(kor, eng, tree, document=nil)
    @english=eng
    @korean=kor
    @tree=tree
    @document=document
  end
  
  def pattern
    rz=[]
    @tree.each_leaf() {|node| rz<<node.parent.content}
    rz.join('|')
  end
   
end