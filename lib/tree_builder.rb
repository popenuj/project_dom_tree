require_relative 'open_file'
require_relative 'tag_parser'
require_relative 'tag'

class TreeBuilder
  TEXT_TAG_CAPTURE = /(<.+?>)|(?<=>)(.+?)(?=<)/
  DOCTYPE = ("<!doctype html>")

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
      # if match group 1 (tag)
      if tag
        # sets first line (the doctype to the root)
        # if tag == DOCTYPE
        #   @root = tag
        #   @current_node = @root
        # if it is an opening tag create a child
        if open_tag?(tag)
          add_child(tag)
        # if it is a closing tag return to parent node
        elsif close_tag?(tag)
          return_to_parent
        end
      # else it will be text from capture group (text)
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

  # creates a child node, sets it to the current node, and sets parent and child
  def add_child(tag)
    if @current_node == nil
      @root = ParseTag.new(tag).tag
      @current_node = @root
    else
      @parent_node = @current_node
      @current_node = ParseTag.new(tag).tag
      @current_node.parent = @parent_node
      @parent_node.children.push @current_node
    end
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
