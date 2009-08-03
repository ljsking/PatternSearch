require 'rubygems'
require 'stanfordparser'
require 'tree'

class Tagger
  def initialize
    @parser = StanfordParser::LexicalizedParser.new
    @id = 0
  end
  def tag(sentence)
    rz = []
    begin
      root = @parser.apply(sentence)
      @id = 0
      myTreeRoot = Tree::TreeNode.new(@id, root.label.to_s)
      @id += 1
      mktree(root, myTreeRoot)
    rescue => err
    	puts "Exception: tag error with #{sentence} #{err}"
    	err
    end
    return myTreeRoot
  end
  def mktree(n, parent)
    n.children.each(){ |n| 
      newNode = Tree::TreeNode.new(@id, n.label.to_s)
      @id += 1
      parent<< newNode
      mktree(n, newNode) }
  end
end