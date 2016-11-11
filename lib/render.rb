class Render

  def initialize(tree_root)
    render_tree(tree_root)
  end

  # Iterates through the tree recursively and prints each
  # line.
  def render_tree(current_node)
    print current_node.text + "\n"
    current_node.children.each do |child|
      render_tree(child)
    end
  end

end
