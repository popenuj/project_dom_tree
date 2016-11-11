require_relative 'tag'

class ParseTag
  attr_accessor :tag

  TYPE = /(\w+)/
  ATTRIBUTE_PAIR = /\s(.*?)\s*\=\s*['|"](.*?)['|"]/

  # Takes tag from html line and initializes tag struct 
  # creation.
  def initialize(html_snippet)
    @tag = nil
    parse_tag(html_snippet)
  end

  # Makes calls to break tags into constituent parts and
  # forms a new Tag out of them.
  # Saving the html_snippet as a whole string avoids
  # having to reconstruct it when rendering.
  # "<div id="dolphin" class="animal mammal">" will get
  # saved in that exact form as well as its constituent
  # parts being saved in an attribute hash.
  def parse_tag(html_snippet)
    tag_type = parse_tag_type(html_snippet)
    attribute_hash = get_attribute_hash(html_snippet)
    @tag = Tag.new(tag_type, html_snippet, attribute_hash)
  end

  # Returns the type of tag (i.e. <head>, <div>, etc.).
  def parse_tag_type(html_snippet)
    html_snippet.match(TYPE)[0]
  end

  # Makes calls to return an array of attributes and
  # their values and turns it into a hash.
  def get_attribute_hash(html_snippet)
    attributes_array = parse_attributes_and_values(html_snippet)
    build_attribute_hash(attributes_array)
  end

  # Turns attributs and their values into an array (i.e.
  # [["id", "dolphin"], ["class", "animal mammal"]]).
  def parse_attributes_and_values(html_snippet)
    html_snippet.scan(ATTRIBUTE_PAIR)
  end

  # Turns attribute array into a hash (i.e.
  # {"id"=>"dolphin", "class"=>"animal mammal"}).
  def build_attribute_hash(attributes_array)
    attribute_hash = Hash.new
    attributes_array.each do |pair|
      attribute_hash[pair[0]] = pair[1]
    end
    attribute_hash
  end
end
