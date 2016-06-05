require './lib/rxib/constraint/constant'
require './lib/rxib/constraint/align'
require './lib/rxib/constraint/element'

module RXib
  module Constraint
    def self.constraints_from(value, element)
      value.split('-@-').map do |constraint|
        components = constraint.split('-')
        klass = case components.count
                when 1 then Constant
                when 2 then Align
                else fail "Invalid constraint #{value}"
                end

        klass.new(element, components)
      end
    end

    def self.lookup_item(item, element)
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
end
