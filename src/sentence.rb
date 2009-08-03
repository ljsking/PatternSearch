class Sentence
  attr_accessor :english, :korean, :tree
  def initialize(kor, eng, tree)
    @english=eng
    @korean=kor
    @tree=tree
  end
  def pattern
    rz=[]
    @tree.each_leaf() {|node| rz<<node.parent.name}
    rz.join('|')
  end
end