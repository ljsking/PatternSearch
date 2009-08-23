require 'rubygems'
require 'test/unit'
require '../src/indexer'

class IndexerTest < Test::Unit::TestCase
  @@indexer = Indexer.new
  def setup
     @root = Tree::TreeNode.new("1", "R")
     @root << Tree::TreeNode.new("2", "C1") << Tree::TreeNode.new("4", "GC1")
     @root << Tree::TreeNode.new("3", "C2")
  end
  def test_make_group
    groups = @@indexer.make_group(@root)
    assert_equal(3, groups.size)
    group_1 = groups[2]
    nodes = group_1[0]
    height = group_1[1]
    assert_equal(1, height)
    assert_equal(1, nodes.size)
    assert_equal('1', nodes[0].name)
    
    group_2 = groups[1]
    nodes = group_2[0]
    height = group_2[1]
    assert_equal(2, height)
    assert_equal(2, nodes.size)
    assert_equal('2', nodes[0].name)
    assert_equal('3', nodes[1].name)
    
    group_3 = groups[0]
    nodes = group_3[0]
    height = group_3[1]
    assert_equal(3, height)
    assert_equal(1, nodes.size)
    assert_equal('4', nodes[0].name)
  end
  def test_make_patterns
    groups = @@indexer.make_group(@root)
    node = groups[0][0][0]
    assert_equal('4', node.name)
    assert_equal('GC1', node.content)
    parent = node.parent
    node.removeFromParent!
    pattern = @@indexer.make_pattern(@root)
    assert_equal('C1_C2', pattern)
    
    parent<<node
    pattern = @@indexer.make_pattern(@root)
    assert_equal('GC1_C2', pattern)
    
    patterns = @@indexer.make_patterns(@root)
    
    assert_equal(3, patterns.size)
    assert_equal(1, patterns["GC1_C2"])
    assert_equal(1, patterns["C1_C2"])
    assert_equal(1, patterns["R"])
  end
end