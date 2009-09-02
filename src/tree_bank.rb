require 'rubygems'
require 'tree'

class TreeBank
  def initialize(tree)
    @tree = tree
    @patterns = nil
  end
  def patterns
    rz = []
    patterns = make_patterns
    patterns.each do |key, value|
      times = (value*10).round
      (1..times).each do |variable|
        rz<<key
      end
    end
    return rz
  end
  def set_height
    nodes = {}
    @tree.breadth_each do |node|
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
  def make_group
    groups={}
    nodes = set_height
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
  def make_patterns
    if @patterns == nil
      groups = make_group
    
      step = 1.0/groups.size
      point = 1.0
    
      @patterns = {}
      pattern = make_pattern
      @patterns[pattern] = point
    
      (1..groups.size).to_a.reverse.each do |height|
        nodes = groups[height]
        point -= step/2
        nodes.each do |node|
          parent = node.parent
          tmps = []
          if parent != nil
            parent.children.each do |child|
              tmps<<child
            end
            parent.removeAll!
            pattern = make_pattern
            @patterns[pattern] = point
            tmps.each do |child|
              parent<<child
            end
          end
        end
        nodes.each do |node|
          node.removeFromParent!
        end
        point -= step/2
        pattern = make_pattern
        @patterns[pattern] = point
      end
    end
    return @patterns
  end
  def make_pattern
    tags = []
    @tree.each_leaf do |node|
      tags<<node.content
    end
    return tags.join("_")
  end
end