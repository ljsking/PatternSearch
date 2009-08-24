require 'rubygems'
require 'test/unit'
require 'src/indexer'
require 'src/tagger'

class IndexerTest < Test::Unit::TestCase
  @@indexer = Indexer.new
  def setup
     @simple = Tree::TreeNode.new("1", "R")
     @simple << Tree::TreeNode.new("2", "C1") << Tree::TreeNode.new("4", "GC1")
     @simple << Tree::TreeNode.new("3", "C2")
     
     #english = 'How could you say such a terrible thing to your boss?'
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
     @complicate = one
  end
  def test_set_height
    nodes = @@indexer.set_height(@simple)
    assert_equal(4, nodes.size)
    
    assert_equal(nodes['1'][0], 1)
    assert_equal(nodes['2'][0], 2)
    assert_equal(nodes['3'][0], 2)
    assert_equal(nodes['4'][0], 3)
  end
  def test_make_group
    groups = @@indexer.make_group(@simple)
    assert_equal(3, groups.size)
    
    group_1 = groups[1]
    assert_equal(1, group_1.size)
    assert_equal('1', group_1[0].name)
    
    group_2 = groups[2]
    assert_equal(2, group_2.size)
    assert_equal('2', group_2[0].name)
    assert_equal('3', group_2[1].name)
    
    group_3 = groups[3]
    assert_equal(1, group_3.size)
    assert_equal('4', group_3[0].name)
  end
  def test_make_group_with_a_real_thing
    groups = @@indexer.make_group(@complicate)
    
    assert_equal(7, groups.size)
    
    group = groups[7]
    exp = ["PRP$", "NN"]
    assert_equal(2, group.size)
    assert_equal(true, exp.include?(group[0].content))
    assert_equal(true, exp.include?(group[1].content))
    
    group = groups[6]
    exp = ["PDT", "DT", "JJ", "NN", "TO", "NP"]
    assert_equal(6, group.size)
    assert_equal(true, exp.include?(group[0].content))
    assert_equal(true, exp.include?(group[1].content))
    assert_equal(true, exp.include?(group[2].content))
    assert_equal(true, exp.include?(group[3].content))
    assert_equal(true, exp.include?(group[4].content))
    assert_equal(true, exp.include?(group[5].content))
    
    group = groups[5]
    exp = ["PRP", "VB", "NP", "PP"]
    assert_equal(4, group.size)
    assert_equal(true, exp.include?(group[0].content))
    assert_equal(true, exp.include?(group[1].content))
    assert_equal(true, exp.include?(group[2].content))
    assert_equal(true, exp.include?(group[3].content))
    
    group = groups[4]
    exp = ["WRB", "MD", "NP", "VP"]
    assert_equal(4, group.size)
    assert_equal(true, exp.include?(group[0].content))
    assert_equal(true, exp.include?(group[1].content))
    assert_equal(true, exp.include?(group[2].content))
    assert_equal(true, exp.include?(group[3].content))
    
    group = groups[3]
    exp = ["WHADVP", "SQ", "."]
    assert_equal(3, group.size)
    assert_equal(true, exp.include?(group[0].content))
    assert_equal(true, exp.include?(group[1].content))
    assert_equal(true, exp.include?(group[2].content))
    
    group = groups[2]
    exp = ["SBARQ"]
    assert_equal(1, group.size)
    assert_equal(true, exp.include?(group[0].content))
    
    group = groups[1]
    exp = ["Root"]
    assert_equal(1, group.size)
    assert_equal(true, exp.include?(group[0].content))
  end
  def test_make_patterns
    pattern = @@indexer.make_pattern(@simple)
    assert_equal('GC1_C2', pattern)
    
    patterns = @@indexer.make_patterns(@simple)
    
    assert_equal(3, patterns.size)
    assert_equal(1, patterns["GC1_C2"])
    assert_equal(1, patterns["C1_C2"])
    assert_equal(1, patterns["R"])
  end
  def test_make_patterns_with_a_real_sample
    patterns = @@indexer.make_patterns(@complicate)
    assert_equal(1, patterns['WRB_MD_PRP_VB_PDT_DT_JJ_NN_TO_PRP$_NN_.'])
    
    assert_equal(1, patterns['WRB_MD_PRP_VB_PDT_DT_JJ_NN_TO_NP_.'])
    
    assert_equal(1, patterns['WRB_MD_PRP_VB_PDT_DT_JJ_NN_PP_.'])
    assert_equal(1, patterns['WRB_MD_PRP_VB_NP_TO_NP_.'])
    assert_equal(1, patterns['WRB_MD_PRP_VB_NP_PP_.'])
    
    assert_equal(1, patterns['WRB_MD_PRP_VP_.'])
    assert_equal(1, patterns['WRB_MD_NP_VB_NP_PP_.'])
    assert_equal(1, patterns['WRB_MD_NP_VP_.'])
    
    assert_equal(1, patterns['WRB_SQ_.'])
    
    assert_equal(1, patterns['SBARQ'])
    assert_equal(1, patterns['Root'])
  end
end