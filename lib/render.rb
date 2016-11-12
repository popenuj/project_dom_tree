require_relative "tree_builder"

class Renderer
  attr_accessor :root

  def initialize(file)
    root = ::TreeBuilder.new(file).root
    @root = root
  end

  # Iterates through the tree recursively and prints each
  # line.
  # Tried rendering using a depth assignment for each node
  # and then translating that into depth number of blank
  # spaces, but rendering was off and I moved on instead
  # of spending too much time on it.
  def output_tree(current_node = @root)
    # print "#{" " * current_node.depth}" +
    print current_node.text + "\n"
    current_node.children.each do |child|
      output_tree(child)
    end
    return
  end

  # def initial_statistics(current_node = @root)
  #   print current_node.type + "\n"
  #   print current_node.object_id.to_s + "\n"
  #   current_node.children.each { |child| initial_statistics(child)}
  #   return
  # end

  def render(node = @root)
    puts "Attributes for this node: #{p node.text}"
  end

end
