Tag = Struct.new(:type, :attributes)

def parse_tag(tag)

  # take tag
  # populate struct with information from the tag

  type = tag.match(/[^<>]+/)
  test = Tag.new(type, nil)
  return test
end



test_tag = parse_tag("<h1 id='dolphin'>")
puts test_tag.type










# "<div id = 'bim'>"

# "<p class='foo bar' id='baz' name='fozzie'>"

# "<img src='http://www.example.com' title='funny things'>"