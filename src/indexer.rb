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
end