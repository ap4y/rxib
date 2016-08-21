module RXib
  module Constraint
    class Relative
      attr_reader :name, :first_item, :second_item, :constant

      def initialize(element, name, components)
        @name = name
        @first_item = element.get('id')
        @second_item = RXib::Constraint.lookup_item(components[0], element)
        @constant = components[1] || '0'
      end

      def replacement_for?(other)
        self.class == other.class &&
          name == other.name &&
          first_item == other.first_item &&
          second_item == other.second_item
      end
    end
  end
end
