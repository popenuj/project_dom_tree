require_relative 'tag'

class ParseTag
  attr_accessor :tag

  TYPE = /(\w+)/
  ATTRIBUTE_PAIR = /\s(.*?)\s*\=\s*['|"](.*?)['|"]/

  # takes tag from html line and initializes tag struct creation
  def initialize(html_snippet)
    @tag = nil
    parse_tag(html_snippet)
  end

  # makes calls to break tags into constituent parts
  def parse_tag(html_snippet)
    tag_type = parse_tag_type(html_snippet)
    attribute_hash = get_attribute_hash(html_snippet)
    @tag = Tag.new(tag_type, html_snippet, attribute_hash)
  end

  # returns the type of tag (i.e. <head>, <div>, etc.)
  def parse_tag_type(html_snippet)
    html_snippet.match(TYPE)[0]
  end

  # makes calls to return an array of attributes and their values and turns it into a hash
  def get_attribute_hash(html_snippet)
    attributes_array = parse_attributes_and_values(html_snippet)
    build_attribute_hash(attributes_array)
  end

  # turns attributs and their values into an array (i.e. [["id", "dolphin"], ["class", "animal mammal"]])
  def parse_attributes_and_values(html_snippet)
    html_snippet.scan(ATTRIBUTE_PAIR)
  end

  # turns attribute array into a hash (i.e. {"id"=>"dolphin", "class"=>"animal mammal"})
  def build_attribute_hash(attributes_array)
    attribute_hash = Hash.new
    attributes_array.each do |pair|
      attribute_hash[pair[0]] = pair[1]
    end
    attribute_hash
  end
end
