class String

  def del_first(regexp)
    sub(regexp,'')
  end

  def del_first!(regexp)
    sub!(regexp,'')
  end

end

Tag = Struct.new(:type, :attributes)

class Parser

  def initialize(tag)
    @tag = tag
  end

   def parse_tag

    parse_tag_type
    parse_attributes_and_values

    # take tag
    # populate struct with information from the tag

    # tag_contents = tag.match(/[^<>]+/)[0] # "h1 id='dolphin'"  ... class='cass fef dsflkjdf'

    type = tag_contents.match(/(\w+)/)[0] # "h1"
    tag_contents.del_first!(/(\w+)/) # " id='dolphin'"

    attribute = tag_contents.match(/(\w+)/)[0] # "id"
    tag_contents.del_first!(/(\w+)/) # " ='dolphin'"

 # "dolphin"
    # p attribute_val
    tag_contents.del_first!(/(\w+)/) # " =''"
    # p tag_contents

    # test = Tag.new(type, nil)
    # return test
  end

  def parse_tag_type
    tag_type = @tag.match(/(\w+)/)[0]
    p tag_type
  end

  def parse_attributes_and_values
    # grab each attribute/value pair and push to a hash

    # <h1 id='dolphin bluewhale shark'>

    # attribute_val = @tag.match(/\=\s*['|"](.*)['|"]/)

    attribute_val = @tag.scan(/\s(.*)\=\s*['|"](.*)['|"]/)

    p attribute_val
  end

  def parse_values
  end 

end

test_tag = "<h1 id='dolphin bluewhale shark' class='animal amphibian' draggable='false'>"
p = Parser.new(test_tag)
p.parse_tag



# puts test_tag

# <tagtype attribute='attr_value' >
# <tagtype> attribute='attr_value' </tagtype>


# "<div id = 'bim'>"

# "<p class='foo bar' id='baz' name='fozzie'>"

# "<img src='http://www.example.com' title='funny things'>"
