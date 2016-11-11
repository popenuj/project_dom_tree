Tag = Struct.new(:type, :attributes, :parent, :children)

class Node

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

  def initialize(file)
    @file = file  # array of each line in a given html file
    @root = file.shift  #shift off <html> and and set as tree root
  end

  def build_html_tree
    #  

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
