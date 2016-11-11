class Tag
  attr_accessor :type,
                :attributes,
                :text,
                :parent,
                :children

  def initialize(type, text, attributes = nil, parent = nil, children = [])
    @type = type
    @attributes = attributes
    @text = text
    @parent = parent
    @children = children
  end

end
