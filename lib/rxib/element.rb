module RXib
  class Element
    attr_reader :name

    def initialize(name, &block)
      @name = name
      @block = block
    end

    def synthesize
      klass = Class.new(Oga::XML::Element) do
        include DSL
      end
      klass.blueprint(&@block)
      element = klass.new(name: @name)
      element.synthesize
      element
    end
  end
end
