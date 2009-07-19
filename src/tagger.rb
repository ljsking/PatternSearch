require 'rubygems'
require 'stanfordparser'
require 'tree'

class Tagger
  def initialize
    @parser = StanfordParser::LexicalizedParser.new
  end
  def tag(sentence)
    root = @parser.apply(sentence)
    myTreeRoot = Tree::TreeNode.new(root.label)
    mktree(root, myTreeRoot)
    #myTreeRoot.printTree
    rz = []
    myTreeRoot.each_leaf () {|node| rz<<node.parent.name}
    rz = rz[0..-2] if rz[-1].to_s()[0]==46 #eliminate last element '.'
    return rz.join('|')
  end
  def mktree(n, parent)
    n.children.each(){ |n| 
      newNode = Tree::TreeNode.new(n.label)
      parent<< newNode
      mktree(n, newNode) }
  end
end