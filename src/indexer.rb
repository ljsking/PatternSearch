require 'rubygems'
require 'tree'

class Indexer
  def add_index(file)

  end
  def make_group(root)
    groups = []
    group = []
    parent = nil
    height = 1
    
    root.breadth_each do |node|
      if parent != node.parent
        groups << [group, height]
        parent = node.parent
        group = []
        height += 1
      end
      group << node
    end
    groups<<[group, height]
    return groups.reverse
  end
  def make_patterns(tree)
    groups = make_group(tree)
    patterns = {}
    pattern = make_pattern(tree)
    patterns[pattern] = 1
    groups.each do |group|
      nodes = group[0]
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
            parent.children<<child
          end
        end
      end
      nodes.each do |node|
        node.removeFromParent!
      end
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