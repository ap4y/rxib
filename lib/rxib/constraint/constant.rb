module RXib
  module Constraint
    class Constant
      attr_reader :name, :constant

      def initialize(_element, name, components)
        @name = name
        @constant = components[0]
      end

      def replacement_for?(other)
        name == other.name
      end
    end
  end
end
