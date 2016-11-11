require_relative 'open_file'
require_relative 'tag_parser'
require_relative 'tag'

class TreeBuilder
  TEXT_TAG_CAPTURE = /(?<=>)(.+?)(?=<)|(<.+?>)/

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
    # create two match groups
    @file.scan(TEXT_TAG_CAPTURE) do |text, tag|
      # if match group 2 (tag)
      if tag
        # if it is an opening tag create a child
        if open_tag?(tag)
          add_tag(tag)
        # if it is a closing tag return to parent node
        elsif close_tag?(tag)
          return_to_parent
        end
      # match group 1 (text)
      elsif text
        add_text_child(text)
      end
    end
  end

  # calls close_tag? to verify, will return opposite of close tag, so if it is open it will return true
  def open_tag?(tag)
    !close_tag?(tag)
  end

  # checks to see if the tag is a close tag based on whether or not it contains ("</")
  def close_tag?(tag)
    tag.include?("</") ? true : false
  end

  # determines whether or not root needs to be set and delegates tag creation accordingly
  def add_tag(tag)
    if @current_node == nil
      add_root(tag)
    else
      add_child(tag)
    end
  end

  # adds the root node
  def add_root(tag)
    @root = ParseTag.new(tag).tag
    @current_node = @root
  end

  # creates a child node, sets it to the current node, and sets parent and child
  def add_child(tag)
    @parent_node = @current_node
    @current_node = ParseTag.new(tag).tag
    @current_node.parent = @parent_node
    @parent_node.children.push @current_node
  end

  # adds text as a child of current node by creating a new tag with type "text"
  def add_text_child(text)
    text_tag = Tag.new("text", text)
    @current_node.children.push text_tag
    text_tag.parent = @current_node
  end

  # sets current node to current node's parent
  def return_to_parent
    @current_node = @current_node.parent
  end
end
t = TreeBuilder.new('simple_test.html')
p t.root
