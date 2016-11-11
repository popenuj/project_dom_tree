Tag = Struct.new(:type, :attributes)

class Node

  # for each item in the array
  # create a node using struct
  # if no root node, set node as root node
  # add children to that node until we hit closing tag
  # repeat for other children that have an opening tag



  def initialize(tag, parent = nil, children = [])
    @tag = tag
    @parent = parent
    @children = children
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

class Parser

  TYPE = /(\w+)/
  ATTRIBUTE_PAIR = /\s(.*?)\s*\=\s*['|"](.*?)['|"]/

  # parse_tag can check if the snippet is wrapped in carets or not
  # and handle each situation correctly

  def parse_tag(html_snippet)
    tag_type = parse_tag_type(html_snippet)
    attribute_hash = get_attribute_hash(html_snippet)
    Tag.new(tag_type, attribute_hash)
  end

  def parse_tag_type(html_snippet)
    html_snippet.match(TYPE)[0]
  end

  def get_attribute_hash(html_snippet)
    attributes_array = parse_attributes_and_values(html_snippet)
    build_attribute_hash(attributes_array)
  end

  def parse_attributes_and_values(html_snippet)
    html_snippet.scan(ATTRIBUTE_PAIR)
  end

  def build_attribute_hash(attributes_array)
    attribute_hash = Hash.new
    attributes_array.each do |pair|
      attribute_hash[pair[0]] = pair[1]
    end
    attribute_hash
  end

  def has_child?

  end
end

test_tag = "<h1 id='dolphin bluewhale shark' class='animal amphibian' draggable='false'>"
p = Parser.new
p p.parse_tag(test_tag)



# puts test_tag

# <tagtype attribute='attr_value' >
# <tagtype> attribute='attr_value' </tagtype>


# "<div id = 'bim'>"

# "<p class='foo bar' id='baz' name='fozzie'>"

# "<img src='http://www.example.com' title='funny things'>"
