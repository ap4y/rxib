module RXib
  class Element < Oga::XML::Element
    attr_reader :root_element

    def initialize(options = {})
      super(options)
      @attrs = {}
      @elements = {}
    end

    def attribute(name, default: nil)
      attr = Attribute.new(name: RXib.camelize(name), value: default)
      @attrs[name] = attr
      add_attribute(attr)

      define_singleton_method(name) { @attrs[name].value }
      define_singleton_method("#{name}=") { |value| @attrs[name].value = value }
      singleton_class.class_eval do
        alias_method("#{RXib.camelize(name)}=", "#{name}=")
      end
    end

    def element(name, root: false, &block)
      element = Element.new(name: RXib.camelize(name))
      element.instance_eval(&block)

      @root_element = element if root
      @elements[name] = element
      children << element

      define_singleton_method(name) { @elements[name] }
    end

    def color(key: nil, value: nil)
      element = Element.new(name: 'color')

      element.attribute(:key, default: RXib.camelize(key))
      element.attribute(:color_space, default: 'calibratedRGB')
      ColorHelpers.parse_to_attributes(element, value)
      children << element

      @elements[key] = element
      define_singleton_method(key) { @elements[key] }
    end

    def mapped_attribute(name, &block)
      return unless block_given?

      define_singleton_method("#{name}=") { |value| yield(value) }
      singleton_class.class_eval do
        alias_method("#{RXib.camelize(name)}=", "#{name}=")
      end
    end
  end
end
