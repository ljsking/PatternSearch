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
    @tree.each_leaf() do |node|
      rz<<node.parent.content unless node.parent == nil
    end
    rz.join('_')
  end
   
end