module RXib
  class Blueprint
    attr_reader :attributes, :mapped_attributes, :elements, :constraints
    attr_accessor :name

    def initialize
      @attributes = []
      @mapped_attributes = {}
      @elements = []
      @constraints = {}
      @root_element = nil
    end

    def attribute(name, value: nil)
      @attributes << Attribute.new(name, value)
    end

    def mapped_attribute(name, value: nil, &block)
      @mapped_attributes[name] = MappedAttribute.new(name, value: value, &block)
    end

    def element(name, &block)
      @elements << Element.new(name, &block)
    end

    def root
      @root_element
    end

    def root_element(name, &block)
      @root_element = Element.new(name, &block)
    end

    def constraint(name, on: :self)
      @constraints[name] = on
    end

    def synthesize(element)
      element.name = @name if @name
      element.root = @root_element.synthesize if @root_element

      @attributes.each { |attr| element.add_attribute(attr.synthesize) }
      @mapped_attributes.each { |_, attr| element.children << attr.synthesize }

      @elements.each { |el| element.children << el.synthesize }
    end

    def set_attribute(name, value)
      if mapped_attributes.key?(name)
        mapped_attributes[name].value = value
        return
      end

      attr = attributes.find { |a| a.name == name }
      attr.value = value if attr
    end

    private

    def initialize_copy(original)
      super
      @name = name && name.dup
      @attributes = original.attributes.map(&:dup)
      @elements = original.elements.map(&:dup)
      @constraints = constraints.dup
      @mapped_attributes =
        original.mapped_attributes.each_with_object({}) do |(k, v), acc|
        acc[k.dup] = v.dup
      end
      @root_element = original.root && original.root.dup
    end
  end
end
