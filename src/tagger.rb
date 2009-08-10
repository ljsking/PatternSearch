require 'rubygems'
require 'stanfordparser'
require 'tree'

class Tagger
  def initialize
    @parser = StanfordParser::LexicalizedParser.new
    @id = 0
    @preproc = StanfordParser::DocumentPreprocessor.new
  end
  def tag(sentence)
    rz = []
    #
    #puts "tag with #{sentence} in #{sentence.class}"
    begin
      root = @parser.apply(sentence)
    rescue => err
      puts "Exception: parser apply error with #{err}"
      @parser = StanfordParser::LexicalizedParser.new
      self.tag(sentence)
    end
    @id = 0
    myTreeRoot = Tree::TreeNode.new(@id, root.label.to_s)
    @id += 1
    mktree(root, myTreeRoot)
    #
    #	
    #	err
    #end
    return myTreeRoot
  end
  def mktree(n, parent)
    n.children.each(){ |n| 
      newNode = Tree::TreeNode.new(@id, n.label.to_s)
      @id += 1
      parent<< newNode
      mktree(n, newNode) }
  end
  def split_by_sentence(txt)
    @preproc.getSentencesFromString(txt)
  end
end