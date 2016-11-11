require_relative 'open_file'
require_relative 'tag_parser'
require_relative 'tag'
require_relative 'render'

class TreeBuilder
  TAG_TEXT_CAPTURE = /(<.+?>)|(?<=>)(.+?)(?=<)/

  attr_accessor :file,
                :parent_node,
                :current_node,
                :root

  def initialize(file)
    @root = nil
    @file = OpenFile.new(file).file
    @current_node = nil
    @parent_node = nil
    parse_line
  end

  def parse_line
    # Creates and compares two match groups (tag and
    # text) and then delegates their proper handling
    # to other methods.
    @file.scan(TAG_TEXT_CAPTURE) do |tag, text|
      if tag
        if open_tag?(tag)
          add_tag(tag)
        elsif close_tag?(tag)
          add_tag(tag)
          return_to_parent
        end
      elsif text
        add_text_child(text)
      end
    end
  end

  # Calls close_tag? to verify, will return opposite of
  # close tag, so if it is open it will return true.
  def open_tag?(tag)
    !close_tag?(tag)
  end

  # Checks to see if the tag is a close tag based on
  # whether or not it contains ("</").
  def close_tag?(tag)
    tag.include?("</") ? true : false
  end

  # Determines whether or not root needs to be set and
  # delegates tag creation accordingly.
  def add_tag(tag)
    if @current_node == nil
      add_root(tag)
    else
      add_child(tag)
    end
  end

  # Adds the root node.
  def add_root(tag)
    @root = ParseTag.new(tag).tag
    @current_node = @root
  end

  # Creates a child node, sets it to the current node,
  # and sets parent and child.
  def add_child(tag)
    @parent_node = @current_node
    @current_node = ParseTag.new(tag).tag
    @current_node.parent = @parent_node
    @parent_node.children.push @current_node
  end

  # Adds text as a child of current node by creating a
  # new tag with type "text".
  def add_text_child(text)
    text_tag = Tag.new("text", text)
    @current_node.children.push text_tag
    text_tag.parent = @current_node
  end

  # Sets current node to current node's parent.
  def return_to_parent
    @current_node = @current_node.parent
  end

  # Calls render instance passing it @root.
  def render
    Render.new(@root)
  end

end
t = TreeBuilder.new('test.html')
p t.root
p t.render
