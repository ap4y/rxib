require './lib/rxib/constraint/constant'
require './lib/rxib/constraint/relative'
require './lib/rxib/constraint/align'
require './lib/rxib/constraint/element'

module RXib
  module Constraint
    def self.constraints_for(type, value, element)
      value.split('-@-').map do |constraint|
        components = constraint.split('-')
        klass = if type =~ /center/
                  Relative
                elsif components.count == 1
                  Constant
                elsif components.count == 2
                  Align
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
