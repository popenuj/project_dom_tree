class Tag
  attr_accessor :type,
                :attributes,
                :text,
                :parent,
                :children,
                :depth

  # Attributes are set to nil to account for 'text' only
  # classes which just represent in-line text, children is
  # an array of nested tags.
  def initialize(type, text, attributes = nil, parent = nil, children = [], depth = 0)
    @type = type
    @attributes = attributes
    @text = text
    @parent = parent
    @children = children
    @depth = depth
  end
end
