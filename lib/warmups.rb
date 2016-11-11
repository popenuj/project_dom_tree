
class Node

  # for each item in the array
  # create a node using struct
  # if no root node, set node as root node
  # add children to that node until we hit closing tag
  # repeat for other children that have an opening tag

####


  def initialize(tag, parent = nil)
    @tag = tag
    @parent = parent
    @children = []
  end

  def add_child(tag)
    # take a tag, create a node, and push into children array
  end

end

class HTMLTree

["<div>", "div text before", "<p>", "p text", "</p>", "<div>", "more div text", "</div>", "div text after", "</div>"]

  def initialize(file)
    @parser = Parser.new
    @file = file  # array of each line in a given html file
    @root = nil  #shift off <html> and and set as tree root
    @stack = []
    build_html_tree(file)
  end

  def build_html_tree(file)
    file.each do | unit |
      tag = @parser.parse_tag(unit)
      @root ||= Node.new(tag)
      # create node from unit
      # add unit to stack
      # pass unit to has_child?
      # if it has child(ren)
        #
      # if it does not have children remove from the stack



  end
end
test_tag = "<h1 id='dolphin bluewhale shark' class='animal amphibian' draggable='false'>"
p = TagParser.new
p p.parse_tag(test_tag)
