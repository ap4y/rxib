module RXib
  class Element < Oga::XML::Element
    attr_reader :root_element

    def initialize(options = {})
      super(options)
      @attrs = {}
      @elements = {}
    end

    def property(name, default: nil)
      attr = Attribute.new(name: RXib.camelize(name))
      attr.value = default if default
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
      if (element = @elements[key])
        ColorHelpers.update_attributes(element, value)
        return
      end

      element = Element.new(name: 'color')
      element.property(:key, default: RXib.camelize(key))
      element.property(:color_space, default: 'calibratedRGB')
      ColorHelpers.parse_to_attributes(element, value)
      children << element

      @elements[key] = element
      define_singleton_method(key) { @elements[key] }
    end

    def mapped_property(name, &block)
      return unless block_given?

      define_singleton_method("#{name}=") do |value|
        yield(value)
      end
      singleton_class.class_eval do
        alias_method("#{RXib.camelize(name)}=", "#{name}=")
      end
    end

    def constraint(name, value: nil, on: :self)
      Constraint.constraints_for(name, value, self).each do |constraint|
        element = Constraint::Element.new(name, constraint)
        @elements[name] = element
        define_singleton_method(name) { @elements[key] }

        if on == :self
          constraints.children << element
        else
          parent_element.constraints.children << element
        end
      end
    end

    def parent_element
      if parent.name == 'subviews'
        parent.parent
      else
        parent
      end
    end
  end
end
