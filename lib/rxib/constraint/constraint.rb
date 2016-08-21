require './lib/rxib/constraint/constant'
require './lib/rxib/constraint/relative'
require './lib/rxib/constraint/align'
require './lib/rxib/constraint/element'
require './lib/rxib/constraint/dsl'

module RXib
  module Constraint
    def self.constraints_for(name, value, element)
      value.split('-@-').map do |constraint|
        components = constraint.split('-')
        klass = if name =~ /center/
                  Relative
                elsif components.count == 1
                  Constant
                elsif components.count == 2
                  Align
                end

        klass.new(element, name, components)
      end
    end

    def self.lookup_item(item, element)
      return element.parent_element.get('id') if item == '|'

      while (parent = element.parent)
        item = parent.children.find do |e|
          e.get('itemId') == item
        end

        return item.get('id') if item
        element = parent
      end

      fail "Can't find element with #{item}"
    end
  end
end
