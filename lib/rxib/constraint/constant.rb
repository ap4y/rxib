module RXib
  module Constraint
    class Constant
      attr_reader :constant

      def initialize(_element, components)
        @constant = components[0]
      end
    end
  end
end
