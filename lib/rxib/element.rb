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
    end

    def element(name, root: false, &block)
      element = Element.new(name: RXib.camelize(name))
      element.instance_eval(&block)

      @root_element = element if root
      @elements[name] = element
      children << element

      define_singleton_method(name) { @elements[name] }
    end

    private

    def method_missing(name, *args, &block)
      attribute(name.to_s.sub('=', ''), default: args[0]) if name =~ /=/
    end
  end
end
