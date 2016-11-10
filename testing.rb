class String

  def del_first(regexp)
    sub(regexp,'')
  end

  def del_first!(regexp)
    sub!(regexp,'')
  end

end

Tag = Struct.new(:type, :attributes)

def parse_tag(tag)

  # take tag
  # populate struct with information from the tag

  tag_contents = tag.match(/[^<>]+/)[0] # "h1 id='dolphin'"  ... class='cass fef dsflkjdf'

  type = tag_contents.match(/(\w+)/)[0] # "h1"
  tag_contents.del_first!(/(\w+)/) # " id='dolphin'"

  attribute = tag_contents.match(/(\w+)/)[0] # "id"
  tag_contents.del_first!(/(\w+)/) # " ='dolphin'"

  attribute_val = tag_contents.match(/=".*"/) # "dolphin"
  puts attribute_val
  tag_contents.del_first!(/="([^>]*)"/) # " =''"



  # test = Tag.new(type, nil)
  # return test
end



test_tag = parse_tag("<h1 id='dolphin doll fin'>")
# puts test_tag

# <tagtype attribute='attr_value' >
# <tagtype> attribute='attr_value' </tagtype>


# "<div id = 'bim'>"

# "<p class='foo bar' id='baz' name='fozzie'>"

# "<img src='http://www.example.com' title='funny things'>"
