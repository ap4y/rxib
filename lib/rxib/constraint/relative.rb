module RXib
  module Constraint
    class Relative
      attr_reader :first_item, :second_item, :constant

      def initialize(element, components)
        @first_item = element.id
        @second_item = RXib::Constraint.lookup_item(components[0], element)
        @constant = components[1] || '0'
      end
    end
  end
end
