class Render

  def initialize(tree_root)
    render_tree(tree_root)
  end

  # Iterates through the tree recursively and prints each
  # line.
  # Tried rendering using a depth assignment for each node
  # and then translating that into depth number of blank
  # spaces, but rendering was off and I moved on instead
  # of spending too much time on it.
  def render_tree(current_node)
    # print "#{" " * current_node.depth}" +
    print current_node.text + "\n"
    current_node.children.each do |child|
      render_tree(child)
    end
  end

end
