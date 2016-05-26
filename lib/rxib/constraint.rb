module RXib
  class ConstantContraintComponents
    attr_reader :constant

    def initialize(_element, components)
      @constant = components[0]
    end
  end

  class AlignConstraintComponents
    attr_reader :constant, :constant_position

    def initialize(element, components)
      if components[0] =~ /[A-Za-z|]/
        @constant_position = :right
        @item_id, @constant = components
      else
        @constant_position = :left
        @constant, @item_id = components
      end

      @element_id = element.id
      @item = lookup_item(@item_id, element)
    end

    def first_item
      constant_position == :left ?  @item : @element_id
    end

    def second_item
      constant_position == :left ? @element_id : @item
    end

    def horizontal_attributes
      if constant_position == :left
        [parent_aligned? ? 'trailing' : 'leading', 'trailing']
      else
        ['leading', parent_aligned? ? 'leading' : 'trailing']
      end
    end

    def vertical_attributes
      if constant_position == :left
        [parent_aligned? ? 'bottom' : 'top', 'bottom']
      else
        ['top', parent_aligned? ? 'top' : 'bottom']
      end
    end

    def parent_aligned?
      @item_id == '|'
    end

    private

    def lookup_item(item, element)
      return element.parent_element.id if item == '|'

      while (parent = element.parent)
        item = parent.children.find do |e|
          e.respond_to?(:item_id) && e.item_id == item
        end

        return item.id if item
        element = parent
      end

      fail "Can't find element with #{item}"
    end
  end

  class Constraint < Element
    def initialize(name, value, element)
      super(name: 'constraint')
      property(:id, default: RXib.generate_id)
      send(name, parse_components(value, element))
    end

    private

    def parse_components(value, element)
      components = value.split('-')

      klass = case components.count
              when 1 then ConstantContraintComponents
              when 2 then AlignConstraintComponents
              else
                fail "Invalid constraint #{value}"
      end
      klass.new(element, components)
    end

    def width(constraint)
      property(:first_attribute, default: 'width')
      property(:constant, default: constraint.constant)
    end

    def height(constraint)
      property(:first_attribute, default: 'height')
      property(:constant, default: constraint.constant)
    end

    def horizontal(constraint)
      property(:constant, default: constraint.constant)

      property(:first_item, default: constraint.first_item)
      property(:second_item, default: constraint.second_item)

      attributes = constraint.horizontal_attributes
      property(:first_attribute, default: attributes[0])
      property(:second_attribute, default: attributes[1])
    end

    def vertical(constraint)
      property(:constant, default: constraint.constant)

      property(:first_item, default: constraint.first_item)
      property(:second_item, default: constraint.second_item)

      attributes = constraint.vertical_attributes
      property(:first_attribute, default: attributes[0])
      property(:second_attribute, default: attributes[1])
    end
  end
end
