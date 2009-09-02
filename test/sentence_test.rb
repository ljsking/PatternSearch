require 'rubygems'
require 'test/unit'
require 'tree'
require 'src/tree_bank'
require 'src/sentence'

class SentenceTest < Test::Unit::TestCase
  def setup
    #How could you say such a terrible thing to your boss ?
    one = Tree::TreeNode.new("1", "Root")
    two = Tree::TreeNode.new("2", "SBARQ")
    three = Tree::TreeNode.new("3", "WHADVP")
    four = Tree::TreeNode.new("4", "SQ")
    five = Tree::TreeNode.new("5", ".")
    six = Tree::TreeNode.new("6", "WRB")
    seven = Tree::TreeNode.new("7", "MD")
    eight = Tree::TreeNode.new("8", "NP")
    nine = Tree::TreeNode.new("9", "VP")
    ten = Tree::TreeNode.new("10", "PRP")
    eleven = Tree::TreeNode.new("11", "VB")
    twelve = Tree::TreeNode.new("12", "NP")
    thirteen = Tree::TreeNode.new("13", "PP")
    fourteen = Tree::TreeNode.new("14", "PDT")
    fifteen = Tree::TreeNode.new("15", "DT")
    sixteen = Tree::TreeNode.new("16", "JJ")
    seventeen = Tree::TreeNode.new("17", "NN")
    eighteen = Tree::TreeNode.new("18", "TO")
    nineteen = Tree::TreeNode.new("19", "NP")
    twenty = Tree::TreeNode.new("20", "PRP$")
    twenty_one = Tree::TreeNode.new("21", "NN")

    one<<two
    two<<three
    two<<four
    two<<five
    three<<six
    four<<seven
    four<<eight
    four<<nine
    eight<<ten
    nine<<eleven
    nine<<twelve
    nine<<thirteen
    twelve<<fourteen
    twelve<<fifteen
    twelve<<sixteen
    twelve<<seventeen
    thirteen<<eighteen
    thirteen<<nineteen
    nineteen<<twenty
    nineteen<<twenty_one
    @sentence = Sentence.new('어떻게 상사에게 그런 심한 말을 할 수 있었어?',' How could you say such a terrible thing to your boss ?',one)
  end
  def test_verbs
    verbs = @sentence.verbs
    assert_equal(1, verbs.size)
    assert_equal(true, verbs.include?('say'))
  end
end