module RXib
  class MappedAttribute
    module DSL
      def color(key)
        self.name = 'color'

        attr = Oga::XML::Attribute.new(name: 'key', value: key)
        add_attribute(attr)

        attr = Oga::XML::Attribute.new(name: 'colorSpace',
                                       value: 'calibratedRGB')
        add_attribute(attr)
      end

      def font_description
        self.name = 'fontDescription'

        attr = Oga::XML::Attribute.new(name: 'key', value: 'fontDescription')
        add_attribute(attr)
      end

      def constraint(type, on: :self)
        self.name = 'constraint'

        Constraint.constraints_for(name, value, self).each do |constraint|
          element = Constraint::Element.new(name, constraint)
          @elements[name] = element
          define_singleton_method(name) { @elements[key] }

          # if on == :self
          #   constraints.children << element
          # else
          #   parent_element.constraints.children << element
          # end
        end
      end

      def set(name, value)
        return super(name, value) unless name == mapping_key

        case self.name
        when 'color'
          color = Color.new(value)
          Color.assign_attributes(self, color)
        when 'fontDescription'
          font = Font.font_for(value)
          Font.assign_attributes(self, font)
        when 'constraint'
          constraints = Constraint.constraints_for(name, value, self)
          constraints.each { |c| Constraint.assign_attributes(self, c) }
        end
      end
    end

    attr_reader :name
    attr_accessor :value

    def initialize(name, value: nil, &block)
      @name = name
      @value = value
      @block = block
    end

    def synthesize
      klass = Class.new(Oga::XML::Element) do
        include DSL

        attr_accessor :mapping_key
      end
      element = klass.new
      element.mapping_key = @name
      element.instance_eval(&@block)
      element.set(@name, @value) if @value
      element
    end
  end
end
