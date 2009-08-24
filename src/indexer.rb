require 'rubygems'
require 'tree'

class Indexer
  def add_index(file)

  end
  def set_height(tree)
    nodes = {}
    tree.breadth_each do |node|
      if node.isRoot?
        height=1
      else
        parent = node.parent
        arr = nodes[parent.name]
        parent_height = arr[0]
        height = parent_height+1
      end
      nodes[node.name] = [height, node]
    end
    return nodes
  end
  def make_group(root)
    groups={}
    nodes = set_height(root)
    nodes.each_value do |value|
      height = value[0]
      node = value[1]
      arr=groups[height]
      if arr==nil
        arr=[]
        groups[height]=arr
      end
      arr<<node
    end
    return groups
  end
  def make_patterns(tree)
    groups = make_group(tree)
    patterns = {}
    pattern = make_pattern(tree)
    patterns[pattern] = 1
    
    (1..groups.size).to_a.reverse.each do |height|
      nodes = groups[height]
      nodes.each do |node|
        parent = node.parent
        tmps = []
        if parent != nil
          parent.children.each do |child|
            tmps<<child
          end
          parent.removeAll!
          pattern = make_pattern(tree)
          patterns[pattern] = 1
          tmps.each do |child|
            parent<<child
          end
        end
      end
      nodes.each do |node|
        node.removeFromParent!
      end
      pattern = make_pattern(tree)
      patterns[pattern] = 1
    end
    return patterns
  end
  def make_pattern(tree)
    tags = []
    tree.each_leaf() do |node|
      tags<<node.content
    end
    return tags.join("_")
  end
end